package routes

import (
	"boilerplate-golang/app/controllers"
	"boilerplate-golang/pkg/middleware"

	"github.com/gofiber/fiber/v2"
)

// PrivateRoutes func for describe group of private routes.
func PrivateRoutes(a *fiber.App) {
	// Create routes group.
	route := a.Group("/api/private", middleware.JWTProtected())

	// Routes for POST method:
	route.Post("/user", controllers.CreateUser) // create a new user

	// Routes for PATCH method:
	route.Patch("/user", controllers.UpdateUser) // update one user by ID

	// Routes for DELETE method:
	route.Delete("/user", controllers.DeleteUser) // delete one user by ID
}
