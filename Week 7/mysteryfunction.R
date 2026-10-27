
mysteryfunction <- function(arg1, arg2, arg3, arg4, arg5){
  # Generate points for a smooth math-based smile curve (parabola)
  smile_x <- seq(-0.4, 0.4, length.out = arg1)
  smile_y <- 2 * (smile_x)^2 - 0.4  # y = ax^2 + c
  
  smile_data <- data.frame(x = smile_x, y = smile_y)
  
  ggplot() +
    # Face Outline (Using a single large point)
    annotate("point", x = 0, y = 0, size = 95, color = arg2) +
    # Eyes
    annotate("point", x = c(-0.3, 0.3), y = c(0.2, 0.2), size = arg3, color = "#2C3E50") +
    # Smile Curve
    geom_path(data = smile_data, aes(x = x, y = y), color = "#2C3E50", size = arg4, lineend = "round") +
    # Greeting Text
    annotate("text", x = 0, y = arg5, label = random_praise(), 
             size = 7, fontface = "bold", color = "#2C3E50") +
    # Format constraints
    coord_fixed(xlim = c(-1.2, 1.2), ylim = c(-1.1, 1.1)) +
    theme_void()
}



