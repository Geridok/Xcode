ios-review 3 days ago
Да, все верно!

deinit - это последний этап перед уничтожением объекта, перед удалением его из памяти.
В deinit можно производить зачистку ресурсов, которые не управляются ARC.
Попробуете привести примеры таких ресурсов?
Будет здорово, если найдете такой пример и в iOS SDKs.

Первое и единственно что пришло в голову, это ресурсы которые мы выделяем самостоятельно, их и нужно отчищать. Сколько я не гуглил не удалось найти ответ про IOS SDKs,
Можете помочь и дать где почитать, вообще изучил эту статью: https://www.raywenderlich.com/966538-arc-and-memory-management-in-swift

Так же был вопрос:
Являются ли: UINavigationBar, UINavigationItem, UITabBar и UITabBarItem - контроллерами?
Ответ - нет, не являются.

Вопросы от меня😇:
1) Можно ли сделать так, что когда в Button вставляешь круглую картинку (а button квадратная), при нажатии пользователем, выделялась только картинка, а не весь квадрат (у меня так на кнопке Generate)
2) Когда я добавляю view.SubView, нужно ли их потом удалять (ограничен ли стэк), и если да, то как это делать?
