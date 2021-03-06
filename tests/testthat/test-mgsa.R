test.objects <- letters[1:7]

test.sets <- list(
      I = c( "a", "b", "c", "d", "e" ),
      II = c( "a", "b" ),
      III = c( "a", "b", "d" ),
      IV = c( "a", "c", "e" ),
      V = c( "e" ),
      VI = c( "b", "e" ) )
test.item_anno <- data.frame( x = 1:4, row.names = c( "d", "b", "c", "a" ) )
test.set_anno <- data.frame( y = 1:4, row.names = c( "III", "V", "I", "VI" ) )

test_that("mgsa() runs with the default parameters", {
  
  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )
  mgsa.result <- mgsa( test.objects, mgsa.simple, debug=0 )
  
  expect_is( mgsa.result, 'MgsaMcmcResults' )
} )

test_that("mgsa() runs with logical mask", {
  
  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )
  mgsa.result <- mgsa( seq_along(test.objects) %% 2 == 0, mgsa.simple@sets, debug=0 )
  
  expect_is( mgsa.result, 'MgsaMcmcResults' )
} )

test_that("mgsa() runs with integer items", {
  
  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )
  mgsa.result <- mgsa( 1:4, mgsa.simple@sets, debug=0 )
  
  expect_is( mgsa.result, 'MgsaMcmcResults' )
} )

test_that("mgsa() works with explict p", {

  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )
  mgsa.result <- mgsa( 1:4, mgsa.simple@sets, debug=0, p = 0.2 )

  expect_is( mgsa.result, 'MgsaMcmcResults' )
  expect_equal( pPost(mgsa.result)$value, c(0.2))
} )

test_that("mgsa() works with explict multiple p", {

  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )

  mgsa.result <- mgsa( 1:4, mgsa.simple@sets, debug=0, p = c(0.2,0.4,0.6) )
  expect_is( mgsa.result, 'MgsaMcmcResults' )
  expect_equal( pPost(mgsa.result)$value, c(0.2,0.4,0.6))

} )

test_that("mgsa() with character,MgsaSets signature works with explict multiple p", {

  mgsa.simple <- new( "MgsaSets", sets=test.sets,
                      itemAnnotations = test.item_anno,
                      setAnnotations = test.set_anno )

  mgsa.result <- mgsa( test.sets[[1]], mgsa.simple, debug=0, p = c(0.2,0.4,0.6) )
  expect_is( mgsa.result, 'MgsaMcmcResults' )
  expect_equal( pPost(mgsa.result)$value, c(0.2,0.4,0.6))

} )
