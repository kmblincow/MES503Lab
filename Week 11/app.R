library(shiny)
library(tidyverse)
library(bslib)
library(later)

# Blackwater Manor Incident: Shiny Escape Room
# SETUP: save as app.R in a project folder. Create a subfolder named www and
# add entrance.jpg, library.jpg, specimen_room.jpg, laboratory.jpg,
# and ghost_study.jpg. Install Shiny with install.packages("shiny"), then
# open app.R in RStudio and click Run App.
# Students analyze the CSVs in R separately, then enter answers in this app.

library(shiny)

# Update the specimen answer if your final dataset has a different first date
# where growth_rate_mm_day exceeds 10.
answer_key <- list(
  frontdoor = "enter",
  entrance = "107",
  library = "scina borealis",
  specimen = "1926-10-23",
  laboratory = "p < 0.001",
  study = "*"
)

rooms <- list(
  list(number=1, title = "Blackwater Manor", image="manor.jpg",
       scene="Blackwater Manor looms large in front of you. You are beginning to question whether this is a good idea as you hear scurrying sounds from behind a window. You are definitely reconsidering your choice to come here at night... But you and your research team are determined to find out what Dr. Wren discovered. You enter the manor.",
       puzzle_title="Enter Blackwater Manor",
       puzzle="Click on the stars to investigate the environment. When you're ready to enter, type 'ENTER' into the 'Your answer:' box.",
       hint="Type 'ENTER' into the 'Your answer:' box.",
       hotspots=list(list(id="lower_window",label="Lower window",x=60,y=63,message="You peek through the window and see a flash of blue light and hear something scurrying across the room."),
                     list(id="entrance_door",label="Front door",x=55,y=63,message="The door appears to be unlocked. Are you brave enough to enter?")
       )),
  list(number=2, title="The Entrance Hall", image="EntranceHall.jpg",
       scene="The front door slams shut behind you. Dust hangs in the air, and salt-stained portraits watch over a grand entrance hall. Candles light of their own accord throughout the room in what will prove to be the first of many supernatural occurrences this night. A notebook lies open on a side table. The notebook pages start flicking rapidly until they eventually settle on a page depicting a data table. Your team quickly digitizes the data: wren_initial_observations.csv",
       puzzle_title="The Observation That Doesn't Belong",
       puzzle="Inspect wren_initial_observations.csv in R and identify the observation that is inconsistent with the others. Enter its observation ID to access the next room.",
       hint="Compare the values across observations. Look for a row whose measurements are wildly inconsistent with the rest.",
       hotspots=list(
         list(id="entrance_notebook",label="Open notebook",x=22,y=70,message="The notebook reads: ‘Trust the measurements, not the handwriting. One record is impossible.’"),
         list(id="entrance_clock",label="Stopped clock",x=85,y=50,message="The clock's hands are frozen at 11:59. Time has no meaning here."),
         list(id="entrance_door",label="Front door",x=49,y=70,message="The door will not budge. Whatever happened here, the only way out may be forward.")
       )),
  list(number=3, title="The Library", image="Library.jpg",
       scene="Tall shelves lean beneath the weight of marine biology texts. Specimen catalogs and handwritten notes cover a reading table. A faint blue glow flickers between the pages of an open ledger. When you turn to that page you see a note written, could it be from the ghost of Dr. Wren?: 'Identify the organism I studied most and filter for my fifth level study to discover notes on what I was working on before my disappearance. The name of this species will take you deeper into my home and into the mystery of my demise.'",
       puzzle_title="A Name Buried in the Records",
       puzzle="Using wren_research_studies.csv, identify the species Dr. Wren studied the most, then filter for level 5 studies of this species. The study notes will give a hint as to where we are headed. Enter the species name to advance to the next room.",
       hint="Check spelling carefully. The species name has a genus and a species.",
       hotspots=list(
         list(id="library_ledger",label="Specimen ledger",x=52,y=48,message="Laboratory Note — October 12: ‘Some amphipods grow at an extraordinary rate, while others exposed to similar temperatures remain unchanged. The temperature hypothesis remains promising, but I cannot explain the inconsistency.’"),
         list(id="library_book",label="Old textbook",x=20,y=35,message="A dusty volume titled Marine Biology at Oxford. Its margins are filled with unrelated notes about tides."),
         list(id="library_drawer",label="Catalog drawer",x=80,y=51,message="The catalog contains repeated entries. Several specimens were logged more than once.")
       )),
  list(number=4, title="The Specimen Room", image="SpecimenRoom.png",
       scene="Glass jars line the walls. Some contain only cloudy seawater; others pulse with a dim blue light. On the floor, the remains of a large aquarium glitter beneath a trail of wet marks. A note under a poster of growth rate reads:
'The growth rate was stable for days. Then something changed.
I recorded the growth even as I realized it was becoming dangerous. The first sign that things might get out of control was when growth exceeded 5 mm/day. I visualized the data to evaluate my temperature hypothesis and found the date of the first observation that crossed the threshold.' You find the data he wrote about and digitize it: wren_growth_timeseries.csv. Could recreating Dr. Wren's visual help solve the mystery?
",
       puzzle_title="The Temperature Threshold",
       puzzle="Using wren_growth_timeseries.csv, plot growth rate over time, coloring points based on temperature, and add a horizontal line at 5 mm/day. Find the first date on which growth exceeded this threshold. Enter the date as YYYY-MM-DD.",
       hint="Use the date column and find the earliest observation with growth_rate_mm_day greater than 5.",
       hotspots=list(
         list(id="specimen_jar",label="Glowing jar",x=5,y=38,message="The label reads: ‘Growth rate recorded daily. If the curve rises beyond the dashed line, stop the experiment.’"),
         list(id="specimen_glass",label="Broken aquarium",x=65,y=58,message="Deep scratches score the inside of the glass. Something appears to have forced its way out."),
         list(id="specimen_chart",label="Growth chart",x=79,y=29,message="The chart is incomplete, but the final points climb sharply. The temperature record alone does not explain the sudden change.")
       )),
  list(number=5, title="The Laboratory", image="Lab.png",
       scene="The laboratory smells of salt, rust, and something faintly sweet. Four experimental tanks stand beneath a bank of old instruments. Labels identify different combinations of temperature and nutrients. A research note reads:
'Temperature alone has not explained the observations. I examined the nutrient treatments next.
The nutrient-rich tanks appeared to contain rapidly growing specimens, but visual inspection was not sufficient. I ran a test to determine whether mean growth rate differed between the nutrient treatments.' Suddenly, a disembodied voice echoes throughout the room: 'Demonstrate your worthiness to learn what happened to me by running a statistical test and showing me how you would report the p-value.'
After gathering yourself, you find a dataset of experimental growth measurements that you digitize: wren_nutrient_experiment.csv 
",
       puzzle_title="The Nutrient Hypothesis",
       puzzle="Use the wren_nutrient_experiment.csv data to perform a statistical test to determine whether growth rate differs between nutrient treatments. Based on the results of your test, input how you would report the p value (e.g. p = .589).",
       hint="What is the standard protocol for reporting p values? Include spaces similar to the example provided.",
       hotspots=list(
         list(id="lab_tanks",label="Experimental tanks",x=48,y=43,message="The warm, nutrient-rich tank is coated in residue. The other tanks show far less growth."),
         list(id="lab_instruments",label="Instruments",x=55,y=25,message="The temperature probes were recalibrated twice. The records say the nutrient treatments were prepared separately."),
         list(id="lab_notebook",label="Research notebook",x=20,y=55,message="A note reads: ‘Nutrients appear to matter, but this analysis ignores temperature. I must test the conditions together.’")
       )),
  list(number=6, title="The Ghost's Study", image="ghost_study.png",
       scene="The study is almost completely dark. Papers cover the desk, and a cracked aquarium sits on its corner. A research note lies beneath a deep gouge in the wood: 'Temperature alone did not explain the growth. Nutrients alone did not explain the growth.
What happens when both conditions occur together?' The disembodied voice is now accompanied with a spectral vision of Dr. Wren himself. He says,
'The answer to my mystery will be revealed if you can tell me about a statistical model that excels at combining nutrients and temperature to explain the growth rates I observed.' He then fades into nothingness. You digitize the accompanying dataset: wren_final_experiment.csv.
" ,
       puzzle_title="The Final Interaction",
       puzzle="Fit two models using temperature and nutrients to predict growth rate. Enter the character you used to connect the explanatory varaiables in the syntax of the 'best' model (i.e. * or +).",
       hint="Use AIC to evaluate which model is the best.",
       hotspots=list(
         list(id="study_graph",label="Data Visual",x=52,y=45,message="The final analysis compares additive and interaction models."),
         list(id="study_note",label="Final note",x=70,y=75,message="‘Neither temperature nor nutrients alone explains what happened. The transformation occurs when the two conditions coincide.’"),
         list(id="study_aquarium",label="Cracked aquarium",x=73,y=38,message="The glass is cracked outward. Something large escaped this room.")
       ))
)

ui <- fluidPage(
  tags$head(
    tags$title("The Blackwater Manor Incident"),
    tags$style(HTML("
      body { background:#111416; color:#eee9df; font-family:Georgia,'Times New Roman',serif; }
      .app-header { text-align:center; padding:14px 8px 8px; }
      .app-header h1 { color:#d9c69a; letter-spacing:2px; font-size:30px; margin-bottom:4px; }
      .app-header p { color:#b9b4a9; margin-top:0; }
      .progress-line { text-align:center; color:#c8b98f; margin-bottom:12px; letter-spacing:1px; }
      .room-scene { position:relative; width:100%; height:min(68vh,650px); min-height:420px; background-size:cover; background-position:center; background-repeat:no-repeat; border:1px solid #6e6655; box-shadow:0 0 22px rgba(0,0,0,.75); overflow:hidden; }
      .room-scene:after { content:''; position:absolute; inset:0; background:linear-gradient(to bottom,rgba(0,0,0,.04) 30%,rgba(0,0,0,.25) 55%,rgba(0,0,0,.86) 100%); pointer-events:none; }
      .room-title { position:absolute; z-index:2; top:14px; left:18px; padding:7px 12px; background:rgba(8,10,10,.78); color:#e3d2a5; border:1px solid rgba(220,205,165,.5); font-size:20px; letter-spacing:1px; }
      .hotspot { position:absolute; z-index:3; transform:translate(-50%,-50%); border:1px solid #f0dca6; background:rgba(12,16,16,.82); color:#fff5d9; border-radius:50%; width:38px; height:38px; font-size:18px; box-shadow:0 0 12px rgba(240,220,166,.55); cursor:pointer; padding:0; }
      .hotspot:hover,.hotspot:focus { background:#d7c18b; color:#171717; box-shadow:0 0 18px rgba(255,230,160,.9); }
      .narrative-bubble { position:absolute; z-index:4; left:4%; right:4%; bottom:15px; background:rgba(8,10,10,.9); border:1px solid #b9a77a; border-radius:14px; padding:14px 18px; color:#f2eee4; box-shadow:0 3px 14px rgba(0,0,0,.6); font-size:16px; line-height:1.45; }
      .narrative-bubble .clue { color:#e3ce94; margin-top:8px; font-style:italic; }
      .puzzle-panel { margin:14px auto 26px; padding:18px 22px; max-width:950px; background:#202526; border:1px solid #5f604f; border-radius:8px; }
      .puzzle-panel h3 { color:#e3d2a5; margin-top:0; }
      .puzzle-panel p { color:#e4e0d7; }
      .form-control { background:#f1eee6; color:#171717; }
      .btn-primary { background:#746443; border-color:#c7b17d; color:white; }
      .btn-primary:hover { background:#9a8457; border-color:#e4d3a5; }
      .btn-default { background:#333a39; border-color:#7a7a6b; color:#f2eee4; }
      .status-message { padding:10px 12px; margin-top:12px; border-left:4px solid #b9a77a; background:#171b1b; min-height:20px; }
      .ending { max-width:900px; margin:35px auto; padding:30px; background:#080909; border:1px solid #746443; text-align:center; line-height:1.8; font-size:19px; }
      .ending h2 { color:#d9c69a; }
      @media(max-width:700px) { .room-scene { min-height:520px; height:70vh; } .narrative-bubble { font-size:14px; padding:10px 12px; } .room-title { font-size:16px; } }
    /* Spooky success pop-up */
.modal-content {
  background: #111416;
  color: #eee9df;
  border: 2px solid #b9a77a;
  border-radius: 4px;
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.9);
  font-family: Georgia, serif;
}

.modal-header {
  background: #080909;
  border-bottom: 1px solid #746443;
}

.modal-title {
  color: #d9c69a;
  font-size: 22px;
  letter-spacing: 2px;
  text-transform: uppercase;
}
.modal-body {
  white-space: pre-line;
}
/* Final amphipod reveal */
.finale {
  position: fixed;
  inset: 0;
  z-index: 9999;
  background: #000;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100vw;
  height: 100vh;
}

.finale img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.finale-end {
  position: fixed;
  inset: 0;
  z-index: 10000;
  background: #000;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #eee9df;
  font-family: Georgia, serif;
  font-size: 48px;
  letter-spacing: 10px;
}"))
  ),
  div(class="app-header", h1("THE BLACKWATER MANOR INCIDENT"), p("A data-science escape room")),
  uiOutput("game_ui")
)

server <- function(input, output, session) {
  current_room <- reactiveVal(1)
  clue_text <- reactiveVal("")
  status_text <- reactiveVal("Inspect the room, solve the puzzle in R, and enter your answer.")
  pending_room <- reactiveVal(NULL)
  finale_stage <- reactiveVal("playing")
  
  make_hotspot <- function(h) {
    actionButton(inputId=h$id, label=HTML("✦"), title=h$label, class="hotspot",
                 style=sprintf("left:%s%%; top:%s%%;", h$x, h$y))
  }
  
  output$game_ui <- renderUI({
    
    # Stage 1: Show the amphipod
    if (finale_stage() == "creature") {
      return(
        div(
          class = "finale",
          tags$img(
            src = "amphipod.png",
            alt = "A gigantic glowing amphipod"
          )
        )
      )
    }
    
    # Stage 2: Show the black screen and END
    if (finale_stage() == "end") {
      return(
        div(
          class = "finale-end",
          "END"
        )
      )
    }
    
    # Otherwise, display the current room
    r <- current_room()
    
    if (r > length(rooms)) {
      return(NULL)
    }
    
    room <- rooms[[r]]
    scene_style <- sprintf("background-image:url('%s');", room$image)
    tagList(
      div(class="progress-line", paste0("ROOM ", room$number, " OF 6  •  ", toupper(room$title))),
      div(class="room-scene", style=scene_style,
          div(class="room-title", room$title),
          lapply(room$hotspots, make_hotspot),
          div(class="narrative-bubble",
              div(room$scene),
              if (nzchar(clue_text())) div(class="clue", clue_text())
          )
      ),
      div(class="puzzle-panel",
          h3(room$puzzle_title), p(room$puzzle),
          textInput("answer", "Your answer:", value="", placeholder="Enter your answer here"),
          fluidRow(
            column(6, actionButton("submit_answer", "Submit answer", class="btn-primary")),
            column(6, actionButton("show_hint", "Request a hint", class="btn-default"))
          ),
          div(class="status-message", textOutput("status_text"))
      )
    )
  })
  outputOptions(output, "game_ui", suspendWhenHidden=FALSE)
  output$status_text <- renderText(status_text())
  
  
  # observeEvent(input$reveal_creature, {
  #   showModal(
  #     modalDialog(
  #       title = "LOOK OUT!",
  #       tags$img(
  #         src = "amphipod.png",
  #         style = "width: 100%; height: auto; display: block;"
  #       ),
  #       size = "l",
  #       easyClose = TRUE,
  #       footer = modalButton("Close")
  #     )
  #   )
  # })
  
  
  hotspot_ids <- unlist(lapply(rooms, function(room) {
    vapply(room$hotspots, function(h) h$id, character(1))
  }))
  for (id in hotspot_ids) {
    local({
      hotspot_id <- id
      observeEvent(input[[hotspot_id]], {
        r <- current_room()
        if (r <= length(rooms)) {
          found <- Filter(function(h) h$id == hotspot_id, rooms[[r]]$hotspots)
          if (length(found)) {
            clue_text(found[[1]]$message)
            status_text(paste("You inspect:", found[[1]]$label))
          }
        }
      }, ignoreInit=TRUE)
    })
  }
  
  observeEvent(input$submit_answer, {
    
    r <- current_room()
    
    if (r > length(rooms)) return()
    
    answer <- normalize_answer(input$answer)
    
    correct <- switch(
      as.character(r),
      "1" = identical(answer, normalize_answer(answer_key$frontdoor)),
      "2" = identical(answer, normalize_answer(answer_key$entrance)),
      "3" = identical(answer, normalize_answer(answer_key$library)),
      "4" = identical(answer, normalize_answer(answer_key$specimen)),
      "5" = identical(answer, normalize_answer(answer_key$laboratory)),
      "6" = identical(answer, normalize_answer(answer_key$study)),
      FALSE
    )
    
    if (correct) {
      
      # Success message for each room
      messages <- c(
        "The front door groans open. Somewhere inside, something scurries across the floor. You step into Blackwater Manor.",
        "The notebook snaps shut. A hidden mechanism clicks, and the library door slowly swings open.",
        "A latch clicks behind the specimen catalog. Cold, blue light spills through a newly revealed doorway.",
        "The laboratory door unlocks with a heavy metallic clang. From somewhere beyond it comes a faint, wet scraping sound.",
        "Another door creaks open revealing a Dr. Wren's secret study. Papers flutter across the desk, though there is no wind. Something is waiting inside.",
        "You hear a scraping sound behind you... As you turn you find one final research note. It reads:\n\n  'I understand now. Neither temperature nor nutrients alone explains what happened. The transformation occurs when the two conditions coincide.\n

The organisms have grown far beyond their expected size. They have survived outside the tanks. I can hear something moving in the corridor.\n

I thought I was studying a biological curiosity. I may have created something that should never have existed. If anyone finds this note, do not repeat the experiment.'\n\n 
        The scraping is getting louder behind you. Do you dare to turn around?"
      )
      
      # Store the destination room
      pending_room(r + 1)
      
      # Clear the answer and clue
      clue_text("")
      updateTextInput(session, "answer", value = "")
      
      # Display spooky success modal
      showModal(
        modalDialog(
          title = switch(
            as.character(r),
            "1" = "THE DOOR OPENS",
            "2" = "A SECRET REVEALED",
            "3" = "BEYOND THE SPECIMENS",
            "4" = "THE EXPERIMENT CONTINUES",
            "5" = "SOMETHING IS WAITING",
            "6" = "THE FINAL SECRET"
          ),
          
          tags$p(messages[r]),
          
          footer = actionButton(
            "continue_room",
            "CONTINUE",
            class = "btn-spooky"
          ),
          
          easyClose = FALSE,
          fade = TRUE
        )
      )
      
    } else {
      
      status_text(
        "That answer doesn't unlock the next room. Revisit your analysis, inspect the scene, or request a hint."
      )
      
      updateTextInput(session, "answer", value = "")
    }
    
  })
  
  observeEvent(input$show_hint, {
    r <- current_room()
    if (r <= length(rooms)) status_text(paste("HINT:", rooms[[r]]$hint))
  })

  normalize_answer <- function(x) {
    x <- trimws(tolower(x))
    gsub("\\s+", " ", x)
  }

  # observeEvent(input$submit_answer, {
  #   r <- current_room()
  #   if (r > length(rooms)) return()
  #   answer <- normalize_answer(input$answer)
  #   correct <- switch(as.character(r),
  #                     "1" = identical(answer, answer_key$frontdoor),
  #                     "2" = identical(answer, answer_key$entrance),
  #                     "3" = identical(answer, answer_key$library),
  #                     "4" = identical(answer, answer_key$specimen),
  #                     "5" = identical(answer, answer_key$laboratory),
  #                     "6" = identical(answer, answer_key$study),
  #                     FALSE
  #   )
    # if (correct) {
    #   messages <- c(
    #     "You and your research team step inside Blackwater Manor.",
    #     "Correct. A door swings open, revealing a library.",
    #     "Correct. A hidden latch clicks behind the specimen catalog. You walk through the hidden door to find a room full of specimens.",
    #     "Correct. A door you didn't notice before unlocks with a heavy metallic sound and leads you to a research laboratory.",
    #     "Correct. A door to Dr. Wren's private study swings open.",
    #     ""
    #   )
    #   status_text(messages[r])
    #   current_room(r + 1)
    # } else {
    #   status_text("That answer doesn't unlock the next room. Revisit your analysis, inspect the scene, or request a hint.")
    # }
    # clue_text("")
    # updateTextInput(session, "answer", value="")
  #   
  #   }
  # })
  # Advance only after the student clicks Continue
  # Advance to the next room or begin the finale
  # Advance to the next room or begin the finale
  observeEvent(input$continue_room, {
    next_room <- isolate(pending_room())
    removeModal()
    
    if (!is.null(next_room)) {
      
      if (next_room > length(rooms)) {
        
        # Show the amphipod image
        finale_stage("creature")
        
        # Switch to the END screen after 3 seconds
        later::later(function() {
          shiny::withReactiveDomain(session, {
            finale_stage("end")
          })
        }, delay = 6)
        
      } else {
        current_room(next_room)
      }
      
      pending_room(NULL)
    }
    
  }, ignoreInit = TRUE)
}

shinyApp(ui=ui, server=server)
