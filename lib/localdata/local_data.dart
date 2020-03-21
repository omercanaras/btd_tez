
var finalScore = 0;
var questionNumber = 0;

var question = BeckQuestions();




class BeckQuestions {
  var choices = [
    [
      "Kendimi üzgün hissetmiyorum.",
      "Kendimi üzgün hissediyorum",
      "Her zaman için üzgünüm ve kendimi bu duygudan kurtaramıyorum.",
      "Öylesine üzgün ve mutsuzum ki, dayanamıyorum."
    ],
    [
      "Gelecekten umutsuz değilim.",
      "Geleceğe biraz umutsuz bakıyorum.",
      "Gelecekten beklediğim hiçbir şey yok.",
      "Benim için bir gelecek yok ve bu durum düzelmeyecek."
    ],
    [
      "Kendimi başarısız görmüyorum.",
      "Çevremdeki birçok kişiden daha fazla başarısızlıklarım oldu sayılır.",
      "Geriye dönüp baktığımda, çok fazla başarısızlığımın olduğunu görüyorum.",
      "Kendimi tümüyle başarısız bir insan olarak görüyorum."
    ],
    [
      "Herşeyden eskisi kadar zevk alabiliyorum.",
      "Herşeyden eskisi kadar zevk alamıyorum.",
      "Artık hiçbirşeyden gerçek bir zevk alamıyorum.",
      "Bana zevk veren hiçbirşey yok. Herşey çok sıkıcı."
    ],

    [
      "Kendimi suçlu hissetmiyorum.",
      "Arada bir kendimi suçlu hissettiğim oluyor.",
      "Kendimi çoğunlukla suçlu hissediyorum.",
      "Kendimi her an için suçlu hissediyorum."
    ],
    [
      "Cezalandırıldığımı düşünmüyorum.",
      "Bazı şeyler için cezalandırılabileceğimi hissediyorum.",
      "Cezalandırılmayı bekliyorum.",
      "Cezalandırıldığımı hissediyorum."
    ],
    [
      "Kendimden hoşnutum.",
      "Kendimden pek hoşnut değilim.",
      "Kendimden hiç hoşlanmıyorum.",
      "Kendimden nefret ediyorum."
    ],
    [
      "Kendimi diğer insanlardan daha kötü görmüyorum.",
      "Kendimi zayıflıklarım ve hatalarım için eleştiriyorum.",
      "Kendimi hatalarım için çoğu zaman suçluyorum.",
      "Her kötü olayda kendimi suçluyorum."
    ],
    [
      "Kendimi öldürmek gibi düşüncelerim yok.",
      "Bazen kendimi öldürmeyi düşünüyorum, fakat bunu yapmam.",
      "Kendimi öldürebilmeyi isterdim.",
      "Bir fırsatını bulsam kendimi öldürürdüm."
    ],
    [
      "Her zamankinden daha fazla ağladığımı sanmıyorum.",
      "Eskisine göre şu sıralarda daha fazla ağlıyorum.",
      "Şu sıralarda her an ağlıyorum.",
      "Eskiden ağlayabilirdim, ama şu sıralarda istesem de ağlayamıyorum."
    ],
    [
      "Her zamankinden daha sinirli değilim.",
      "Her zamankinden daha kolayca sinirleniyorum ve kızıyorum.",
      "Çoğu zaman sinirliyim.",
      "Eskiden sinirlendiğim şeylere bile artık sinirlenemiyorum."
    ],
    [
      "Diğer insanlara karşı ilgimi kaybetmedim.",
      "Eskisine göre insanlarla daha az ilgiliyim.",
      "Diğer insanlara karşı ilgimin çoğunu kaybettim.",
      "Diğer insanlara karşı hiç ilgim kalmadı."
    ],
    [
      "Kararlarımı eskisi kadar kolay ve rahat verebiliyorum.",
      "Şu sıralarda kararlarımı vermeyi erteliyorum.",
      "Kararlarımı vermekte oldukça güçlük çekiyorum.",
      "Artık hiç karar veremiyorum."
    ],
    [
      "Dış görünüşümün eskisinden daha kötü olduğunu sanmıyorum.",
      "Yaşlandığımı ve çekiciliğimi kaybettiğimi düşünüyor ve üzülüyorum.",
      "Dış görünüşümde artık değiştirilmesi mümkün olmayan olumsuz değişiklikler olduğunu hissediyorum.",
      "Çok çirkin olduğumu düşünüyorum."
    ],
    [
      "Eskisi kadar iyi çalışabiliyorum.",
      "Bir işe başlayabilmek için eskisine göre kendimi daha fazla zorlamam gerekiyor.",
      "Hangi iş olursa olsun, yapabilmek için kendimi çok zorluyorum.",
      "Hiç bir iş yapamıyorum."
    ],
    [
      "Eskisi kadar rahat uyuyabiliyorum.",
      "Şu sıralarda eskisi kadar rahat uyuyamıyorum.",
      "Eskisine göre 1 veya 2 saat erken uyanıyor ve tekrar uyumakta zorluk çekiyorum.",
      "Eskisine göre çok erken uyanıyor ve tekrar uyuyamıyorum."
    ],
    [
      "Eskisine kıyasla daha çabuk yorulduğumu sanmıyorum.",
      "Eskisinden daha çabuk yoruluyorum.",
      "Şu sıralarda neredeyse herşey beni yoruyor.",
      "Öyle yorgunum ki, hiç birşey yapamıyorum."
    ],
    [
      "İştahım eskisinden pek farklı değil.",
      "İştahım eskisi kadar iyi değil.",
      "Şu sıralarda iştahım epey kötü.",
      "Artık hiç iştahım yok."
    ],
    [
      "Son zamanlarda pek fazla kilo kaybettiğimi sanmıyorum.",
      "Son zamanlarda istemediğim halde üç kilodan fazla kaybettim.",
      "Son zamanlarda istemediğim halde beş kilodan fazla kaybettim.",
      "Son zamanlarda istemediğim halde yedi kilodan fazla kaybettim."
    ],
    [
      "Sağlığım beni pek endişelendirmiyor.",
      "Son zamanlarda ağrı, sızı, mide bozukluğu, kabızlık gibi sorunlarım var.",
      "Ağrı, sızı gibi sıkıntılarım beni epey endişelendirdiği için başka şeyleri düşünmek zor geliyor.",
      "Bu tür sıkıntılar beni öylesine endişelendiriyor ki, artık başka hiçbir şey düşünemiyorum."
    ],
    [
      "Son zamanlarda cinsel yaşantımda dikkatimi çeken hiçbir şey yok.",
      "Eskisine göre cinsel konularla daha az ilgileniyorum.",
      "Şu sıralarda cinsellikle pek ilgili değilim.",
      "Artık, cinsellikle hiçbir ilgim kalmadı."
    ]
  ];
}