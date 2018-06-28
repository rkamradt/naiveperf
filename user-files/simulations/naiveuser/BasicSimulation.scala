package naiveuser

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.util.Random

class BasicSimulation extends Simulation {
  val random = Random

  def generateRandomUser() : Map[String, Any] = {
    Map("username" -> random.nextInt(10000).toString)
  }

  val httpConf = http
    .baseURL("https://api.rlksr.com/naiveuser")
    .acceptHeader("application/json")
    .contentTypeHeader("application/json")
    .doNotTrackHeader("1")

  val scn = scenario("Users") // just get the empty list of users
    .feed(Iterator.continually(generateRandomUser))
    .exec(http("add user")
      .post("/users")
      .body(StringBody("{  \"username\": \"${username}\", \"password\": \"test\"}"))
      .check(status is 201))
    .pause(5)
    .exec(http("get users")
      .get("/users")
      .check(status is 200))
    .pause(5)
    .exec(http("get user")
      .get("/users/${username}")
      .header("password", "test")
      .check(status is 200))

  setUp(
    scn.inject(rampUsers(500) over (150 seconds))
  ).protocols(httpConf)
}
