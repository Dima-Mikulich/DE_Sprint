import scala.annotation.tailrec

object Main {

  def degree2(x: Int): Int = {
    @tailrec
    def degree2Helper(x: Int, accumulator: Int): Int = {
      if (x == 0) {
        println(accumulator)
        accumulator
      } else {
        println(accumulator)
        degree2Helper(x - 1, accumulator*2 )
       }
    }
    degree2Helper(x, 1)
  }

  def simpleRec(x: Int): Int = {
    if (x == 0) {
      val itog: Int = 1
      println(itog)
      itog
    }
    else {
      val itog: Int = 2*simpleRec(x-1)
      println(itog)
      itog
    }

  }
  def main(args: Array[String]): Unit = {
    println("Вызов простой рекурсии")
    simpleRec(10)
    println("Вызов хвостовой рекурсии")
    degree2(10)
  }
}