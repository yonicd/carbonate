testthat::context("uri")

carb <- carbonate::carbon$new(silent_yml = TRUE)

testthat::describe("port", {

  testthat::skip_on_travis()
  testthat::skip_on_cran()
  
  p <- carb$get_port()
  
  it('init',{
    testthat::expect_true(inherits(carb$get_port(),'integer'))
  })
  
  it('reset',{
    carb$set_port()
    testthat::expect_false(p==carb$get_port())    
  })
  
  it('manual',{
    carb$set_port(1234)
    testthat::expect_equal(carb$get_port(),1234L)    
  })
  
})
