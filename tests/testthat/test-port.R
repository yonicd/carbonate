testthat::context("port")

carb <- carbonate::carbon$new(code='123')
p <- carb$get_port()

testthat::describe("port", {

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
