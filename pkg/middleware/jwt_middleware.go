package middleware

import (
	"os"

	"github.com/gofiber/fiber/v2"

	jwtMiddleware "github.com/gofiber/jwt/v2"
)

// JWTProtected func for specify routes group with JWT authentication.
// See: https://github.com/gofiber/jwt
func JWTProtected() fiber.Handler {
	// Create config for JWT authentication middleware.
	config := jwtMiddleware.Config{
		SigningKey: []byte(os.Getenv("JWT_SECRET_KEY")),
		ContextKey: "jwt", // used in private routes
		ErrorHandler: func(c *fiber.Ctx, err error) error {
			// Return status 401 and failed authentication error.
			return c.Status(401).JSON(fiber.Map{
				"error": true,
				"msg":   err.Error(),
			})
		},
	}

	return jwtMiddleware.New(config)
}
