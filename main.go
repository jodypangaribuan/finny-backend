package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
)

type HealthResponse struct {
	Status  string `json:"status"`
	Message string `json:"message"`
}

func main() {
	app := fiber.New()

	app.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(HealthResponse{
			Status:  "ok",
			Message: "Service is healthy",
		})
	})

	port := ":8080"
	log.Printf("Server starting on port %s", port)

	if err := app.Listen(port); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
