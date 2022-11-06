import scala.util.control.Breaks

object Main {


  def main(args: Array[String]): Unit = {
   // ----------------------- Задание b + n
      def GetSalary(income: Int, bonus: Double, compensation: Int)  = {
        var Salary: Double = (math rint (((income + (income * (1 + bonus / 100) + compensation)) / 12) * 0.87)* 100) / 100
        Salary
      }

      println("введите размер годового дохода до вычета налогов:")
      val income =  1200 // scala.io.StdIn.readLine().toInt
      println("введите размер премии – в процентах от годового дохода:")
      val bonus =  500 // scala.io.StdIn.readLine().toDouble
      println("введите размер компенсация питания:")
      val compensation = 100 // scala.io.StdIn.readLine().toInt

      var Salary: Double = GetSalary(income, bonus, compensation)
      println("Размер налога на ЗП в РФ - 13%.")
      println(f"Размер ЗП в месяц после вычета налога: $Salary Руб.")

    //   ----------------------- Задание c

    var ListSalary: List[Int] = List(100, 150, 200, 80, 120, 75)
    val AverageSalary: Double = ListSalary.sum / ListSalary.size

    val GetVariance = (Salary: Double, Average: Double ) => (Salary / Average - 1) * 100

    for (i <- ListSalary ) {

      if (i < AverageSalary) {
        println(f"Зарплата сотрудника - ${i.toInt} меньще, чем средняя на ${-1 * GetVariance(i, AverageSalary).round} %%")
      }
      else if (i > AverageSalary) {
        println(f"Зарплата сотрудника - ${i.toInt} больше, чем средняя на ${GetVariance(i, AverageSalary).round} %%")
      }
      else {
        println(f"Зарплата сотрудника - ${i.toInt} равна средней ")
      }
    }
    //   ----------------------- Задание d

    println(f"Выбирите сотрудника от 0 до ${ListSalary.size-1}")
    //val index = scala.io.StdIn.readLine().toInt
    var k = 0
    val index = k
    while (k < 1 ) {
      println(f"Как себя вел сотрудник \"+\" - хорошо, \"-\" - плохо")
      var attitude = "+" // scala.io.StdIn.readLine()
      if (attitude == "+") {
        k = 2
        ListSalary = ListSalary.updated(index, ListSalary.apply(index) + bonus)
      }
      else if (attitude == "-") {
        k = 2
        ListSalary = ListSalary.updated(index, ListSalary.apply(index) - bonus)
      }
    }
    println(f" Новые зарплаты: $ListSalary")
    println(f"Самая маленькая зарплата: ${ListSalary.min}")
    println(f"Самая большая зарплата: ${ListSalary.max}")

    //   ----------------------- Задание e

    ListSalary = ListSalary :+ 350
    ListSalary = ListSalary :+ 90
    ListSalary = ListSalary.sorted
    println(f" Новые зарплаты: $ListSalary")

    //   ----------------------- Задание f
    def insert[T](list: List[T], i: Int, value: T) = {
      list.take(i) ++ List(value) ++ list.drop(i)
    }
    val NewPerson = 130
    var o: Int = 3
    var TMP_ListSalary: List[Int] = List()
    for (i <- ListSalary ) {

      if ((i > NewPerson) && (o == 3)) {
        o = 2
        TMP_ListSalary =  TMP_ListSalary :+ NewPerson }
      TMP_ListSalary = TMP_ListSalary :+ i
    }
    ListSalary = TMP_ListSalary

    println(f" Новые зарплаты: $ListSalary")

    //   ----------------------- Задание g
      println("Введите нижнию границу зарплаты Midle:")
      val start = 100 // scala.io.StdIn.readLine().toInt
      println("Введите вернию границу зарплаты Midle:")
      val end = 140 //  scala.io.StdIn.readLine().toDouble
    for (i <- ListSalary.indices ) {
      if ((ListSalary(i) < end) && (ListSalary(i) > start )) { println(f"Сотрудник $i - Midle")}}

    //   ----------------------- Задание h

    var increase  = (x:Int) => x + (x*7/100)
    ListSalary = ListSalary.map((x) => increase(x))
    println(f" Новые зарплаты +7%%: $ListSalary")

    //   ----------------------- Задание i
    // junior считаем сотрудников с зарплатой до 100, Midle от 100 до 140, Senior выше 140
    val startMidle = 100
    val startSenior = 140
    val mealJunior = 100
    val mealMidle = 180
    val mealSenior = 200
    TMP_ListSalary = List()
    for (i <- ListSalary) {
      var newSalary:Double = i.toDouble
      if ((i < startMidle) && (i < mealJunior)) {
        newSalary = i.toDouble + i.toDouble*((mealJunior.toDouble - i.toDouble) /100)
      }
      else if ( (i > startMidle) && (i < startSenior) && (i < mealMidle)) {
        newSalary = i.toDouble + i.toDouble * ((mealMidle.toDouble - i.toDouble) / 100)
      }
      else if ((i > startSenior) && (i < mealSenior)) {
        newSalary = i.toDouble + i.toDouble * ((mealSenior.toDouble - i.toDouble) / 100)
      }

      TMP_ListSalary = TMP_ListSalary :+ newSalary.toInt
    }
    ListSalary = TMP_ListSalary
    println(f" Новые зарплаты + рынок: $ListSalary")

    //   ----------------------- Задание k
    val FIO: List[String] = List(
      "Иванов Павел",
      "Петров Василий",
      "Кочетов Валерий",
      "Самохвалова Наталия",
      "Алексеевна Павлова",
      "Лариса Максимовна",
      "Баршев Андрей",
      "Николаевич Оверченков",
    "Захар Михайлович"
    )

    var ListSalaryFIO = (FIO zip ListSalary).toMap
    ListSalaryFIO.foreach { case (key, values) => println(key + " - " + values)}

    //   ----------------------- Задание k

    val maxP = ListSalaryFIO.maxBy(_._2)
    println(f"Самая большая зарплата:  ${maxP._2} у ${maxP._1}")
    val minP = ListSalaryFIO.minBy(_._2)
    println(f"Самая маленькая зарплата:  ${minP._2} у ${minP._1}")

    //   ----------------------- Задание m

    def CryptFIO(FIO: String): String = {
      val out:String =  FIO.split(" ")(1).toString().toLowerCase.replaceAll("[аиеёоуыэюя]", "").reverse
      out
    }

    ListSalaryFIO = ListSalaryFIO.map { case (k, v) => CryptFIO(k) ->  v }
    ListSalaryFIO.foreach { case (key, values) => println(key + " - " + values)}



  }
}