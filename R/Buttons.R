#'Buttons
#'
#'Twitter Bootstrap gives many options for styling buttons that aren't made 
#'available by standard Shiny. Use shinyBS to create buttons of different sizes,
#'shapes, and colors.
#'
#'@section Components:
#'There are two functions in the Buttons family: 
#'  \describe{
#'    \item{\code{\link{bsButton}}}{Used in the UI to create a button. Buttons 
#'    can be of the type \code{action} or \code{toggle}.}
#'    \item{\code{\link{updateButton}}}{Used in the Server logic to modify the
#'    state of a button created with \code{\link{bsButton}}}
#'  }
#'      
#'@details
#'Create a button in the UI with \code{\link{bsButton}}. If \code{type = "action"}
#'the button will behave like the standard \code{\link{actionButton}} in shiny.
#'If \code{type = "toggle"} the button will behave like a \code{\link{checkboxInput}}
#'with an on and off state. It will return \code{TRUE} or \code{FALSE} to the Server
#'depending on its state.
#'
#'You can update the style and state of a \code{\link{bsButton}} from the Server 
#'logic with \code{\link{updateButton}}. For example, a button could be set to
#'\code{disabled = TRUE} until the user has made some other selections, then once
#'those selections have been made, an observer on the Server could use \code{\link{updateButton}}
#'to enable the button allowing the user to proceed. Alternatively, you could set
#'the button to \code{style = "success"} to let them know that the button is ready
#'to be clicked.
#'
#'@section Changes:
#'\code{bsActionButton} and \code{bsToggleButton} were replaced with just 
#'\code{\link{bsButton}} with a \code{type} argument.
#'
#'\code{icon} was added to allow placing an icon in the button.
#' 
#'@examples
#'library(shiny)
#'library(shinyBS)
#'app = shinyApp(
#'  ui = 
#'    fluidPage(
#'      sidebarLayout(
#'        sidebarPanel(
#'          sliderInput("bins",
#'                      "Move the slider to see its effect on the button below:",
#'                      min = 1,
#'                      max = 50,
#'                      value = 1),
#'          bsButton("actTwo", label = "Click me if you dare!", icon = icon("ban")),
#'          tags$p("Clicking the first button below changes the disabled state of the second button."),
#'          bsButton("togOne", label = "Toggle button disabled status", 
#'                   block = TRUE, type = "toggle", value = TRUE),
#'          bsButton("actOne", label = "Block Action Button", block = TRUE)
#'        
#'        ),
#'        mainPanel(
#'          textOutput("exampleText")
#'        )
#'      )  
#'    ),
#'  server = 
#'    function(input, output, session) {
#'      observeEvent(input$togOne, ({
#'        updateButton(session, "actOne", disabled = !input$togOne)
#'      }))
#'      observeEvent(input$bins, ({
#'        
#'        b <- input$bins
#'        disabled = NULL
#'        style = "default"
#'        icon = ""
#'        
#'        if(b < 5) {
#'          disabled = TRUE
#'          icon <- icon("ban")
#'        } else {
#'          disabled = FALSE
#'        }
#'        
#'        if(b < 15 | b > 35) {
#'          style = "danger"
#'        } else if(b < 20 | b > 30) {
#'          style = "warning"
#'        } else {
#'          style = "default"
#'          icon = icon("check")
#'        }
#'      
#'        updateButton(session, "actTwo", disabled = disabled, style = style, icon = icon)
#'      
#'      }))
#'    
#'      output$exampleText <- renderText({
#'        input$actTwo
#'        b <- isolate(input$bins)
#'        txt = ""
#'        if((b > 5 & b < 15) | b > 35) {
#'          txt = "That was dangerous."
#'        } else if((b > 5 & b < 20) | b > 30) {
#'          txt = "I warned you about that."
#'        } else if(b >= 20 &  b <= 30) {
#'          txt = "You have chosen... wisely."
#'        }
#'        return(txt)
#'      })
#'    }
#')
#'\dontrun{
#'  runApp(app)
#'}
#'@templateVar item_name Buttons
#'@templateVar family_name Buttons
#'@template footer
NULL