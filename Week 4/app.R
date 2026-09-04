library(shiny)
library(tidyverse)
library(bslib)

# ============================================================
# 1. PASSWORD
# ============================================================

CORRECT_PASSCODE <- "secret123"


# ============================================================
# 2. THEMES
# ============================================================

# Theme shown on the login screen
login_theme <- bs_theme(
  version = 5,
  bootswatch = "flatly"
)

# Theme shown after successful login
secret_theme <- bs_theme(
  version = 5,
  bootswatch = "quartz"
)


# ============================================================
# 3. LOGIN PAGE
# ============================================================

login_ui <- div(
  
  style = "
    max-width: 400px;
    margin: 100px auto;
    padding: 30px;
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 2px 2px 12px rgba(0,0,0,0.15);
  ",
  
  h2(
    "Enter Passcode",
    align = "center"
  ),
  
  br(),
  
  passwordInput(
    "passcode_input",
    "Passcode:",
    placeholder = "Enter your code here"
  ),
  
  actionButton(
    "submit_btn",
    "Submit",
    class = "btn-primary",
    style = "width: 100%;"
  ),
  
  br(),
  br(),
  
  uiOutput("error_message")
)


# ============================================================
# 4. SECRET PAGE
# ============================================================

main_app_ui <- navbarPage(
  
  title = "My Secured Shiny App",
  
  tabPanel(
    
    "Puppy!",
    
    h1("Welcome to the Secret Page! 🎉"),
    
    p(
      "You have successfully unlocked this page using the correct passcode."
    ),
    
    br(),
    
    # Display the puppy image directly
    img(
      src = "cutepuppy.jpg",
      style = "
        display: block;
        max-width: 100%;
        height: auto;
        margin: 20px auto;
        border-radius: 10px;
      "
    )
  )
)


# ============================================================
# 5. MASTER UI
# ============================================================

# The app starts with the login theme.
# The server switches to the darkly theme after login.

ui <- fluidPage(
  
  theme = login_theme,
  
  uiOutput("dynamic_page")
)


# ============================================================
# 6. SERVER
# ============================================================

server <- function(input, output, session) {
  
  # Track whether the user has successfully logged in
  auth_state <- reactiveVal(FALSE)
  
  
  # ----------------------------------------------------------
  # Handle login
  # ----------------------------------------------------------
  
  observeEvent(input$submit_btn, {
    
    if (input$passcode_input == CORRECT_PASSCODE) {
      
      # User successfully authenticated
      auth_state(TRUE)
      
      # Switch to the Darkly theme
      session$setCurrentTheme(secret_theme)
      
    } else {
      
      # Display an error message
      output$error_message <- renderUI({
        
        div(
          style = "
            color: #dc3545;
            margin-top: 10px;
            font-weight: bold;
          ",
          "❌ Incorrect passcode. Please try again."
        )
      })
    }
  })
  
  
  # ----------------------------------------------------------
  # Switch between login and secret page
  # ----------------------------------------------------------
  
  output$dynamic_page <- renderUI({
    
    if (auth_state()) {
      
      main_app_ui
      
    } else {
      
      login_ui
    }
  })
}


# ============================================================
# 7. RUN THE APPLICATION
# ============================================================

shinyApp(
  ui = ui,
  server = server
)
