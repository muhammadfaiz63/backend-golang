package controllers

import "github.com/gofiber/fiber/v2"

func Hello_world(c *fiber.Ctx) error {
	return c.Status(200).JSON(fiber.Map{
		"error": false,
		"msg":   "hello world",
	})
}
