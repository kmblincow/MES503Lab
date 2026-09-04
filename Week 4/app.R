library(shiny)

# Define the correct passcode
CORRECT_PASSCODE <- "secret123"

# --- 1. Login Page UI ---
login_ui <- fluidPage(
  style = "max-width: 400px; margin: 100px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1);",
  h2("Enter Passcode", align = "center"),
  br(),
  passwordInput("passcode_input", "Passcode:", placeholder = "Enter your code here"),
  actionButton("submit_btn", "Submit", class = "btn-primary btn-block", style = "width: 100%;"),
  br(), br(),
  uiOutput("error_message") # Displays an error message if the code is wrong
)

# --- 2. Main Content Page UI (The target page) ---
main_app_ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "flatly"), # Optional theme to look nice
  navbarPage(
    title = "My Secured Shiny App",
    tabPanel("Dashboard",
             h1("Welcome to the Secret Page! 🎉"),
             p("You have successfully unlocked this page using the correct passcode."),
             plotOutput("example_plot")
    ),
    tabPanel("Settings",
             h3("Application Settings"),
             p("This is another tab on your hidden page.")
    )
  )
)

# --- 3. Combined Master UI ---
# This acts as a placeholder container that swaps between the login and main screens
ui <- uiOutput("dynamic_page")

# --- 4. Server Logic ---
server <- function(input, output, session) {
  
  # Set up a reactive values object to track if the user is authenticated
  auth_state <- reactiveValues(authenticated = FALSE)
  
  # Watch for the submit button click
  observeEvent(input$submit_btn, {
    if (input$passcode_input == CORRECT_PASSCODE) {
      auth_state$authenticated <- TRUE
    } else {
      # Show error message if it's incorrect
      output$error_message <- renderUI({
        div(style = "color: red; margin-top: 10px; font-weight: bold;", 
            "❌ Incorrect passcode. Please try again.")
      })
    }
  })
  
  # Dynamically switch the user interface based on auth_state$authenticated
  output$dynamic_page <- renderUI({
    if (auth_state$authenticated) {
      main_app_ui
    } else {
      login_ui
    }
  })
  
  # Example output rendering for your main page data
  output$example_plot <- renderPlot({
    req(auth_state$authenticated) # Don't run this unless authenticated
    plot(rnorm(100), col = "steelblue", pch = 16, main = "Random Data Distribution")
  })
}

# Run the Application
shinyApp(ui = ui, server = server)