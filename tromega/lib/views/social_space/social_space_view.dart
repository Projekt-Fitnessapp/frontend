import 'package:flutter/material.dart';
import '../../widgets/shared/app_bar.dart';
import '../../data/classes/article.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'article_view.dart';

class SocialSpaceView extends StatelessWidget {
  const SocialSpaceView({Key? key}) : super(key: key);

  static final List<Article> articles = [
    Article(
        "https://images.pexels.com/photos/260352/pexels-photo-260352.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Finden des richtigen Gewichts",
        "Dieser Artikel beschreibt drei Angehensweisen um dein individuelles Trainingsgewicht für das Hypertrophie-Training ermitteln zu können.",
        '''Wenn es um Hypertrophie-Training geht, ist das Gewicht, das du hebst, einer der wichtigsten Faktoren für dein Trainingsergebnis. Wenn du zu leicht hebst, wirst du möglicherweise keine Muskelreize erzeugen, die ausreichen, um das Wachstum zu fördern. Wenn du zu schwer hebst, kannst du dich verletzen und deine Technik beeinträchtigen. Daher ist es wichtig, das individuelle richtige Gewicht für dein Hypertrophie-Training zu finden. Hier sind einige Schritte, die dir dabei helfen können:

Bestimme dein 1-Rep-Maximum (1RM)
Das 1RM ist das maximale Gewicht, das du für eine bestimmte Übung für eine einzige Wiederholung heben kannst. Es ist eine gute Möglichkeit, dein Leistungsniveau zu messen und dein Trainingsgewicht zu bestimmen. Um dein 1RM zu bestimmen, führe die Übung mit zunehmendem Gewicht aus, bis du das maximale Gewicht erreichst, das du für eine einzige Wiederholung bewältigen kannst. Dies erfordert jedoch oft einen Spotter oder eine professionelle Unterstützung.

Bestimme deine 6-10RM-Last
Ein 6-10RM-Last ist das Gewicht, das du für 6-10 Wiederholungen heben kannst, bevor du das Muskelversagen erreichst. Diese Gewichtsbereichsstufe ist ideal für das Hypertrophie-Training, da sie genügend Wiederholungen und Volumen bietet, um das Muskelwachstum zu fördern, ohne dass es zu viel Belastung gibt. Um deine 6-10RM-Last zu finden, beginne mit einer Gewichtsauswahl, die du für sechs Wiederholungen heben kannst, und erhöhe das Gewicht schrittweise, bis du dein maximales Gewicht erreichst, das du für zehn Wiederholungen heben kannst.

Verwende die RPE-Skala
Die RPE-Skala (Rate of Perceived Exertion) ist eine Methode zur Bestimmung der Intensität deines Trainings basierend auf deinem eigenen subjektiven Empfinden. Sie reicht von 0 bis 10, wobei 0 bedeutet, dass du keine Anstrengung spürst, und 10 bedeutet, dass du am absoluten Muskelversagen bist. Eine RPE von 7-8 ist ideal für Hypertrophie-Training und bedeutet, dass du das Gewicht hebst, bei dem du spürst, dass du noch zwei bis drei Wiederholungen ausführen könntest, bevor du das Muskelversagen erreichst.

Berücksichtige deine Technik und deine Erfahrung
Es ist wichtig, deine Technik und Erfahrung bei der Bestimmung des richtigen Gewichts zu berücksichtigen. Wenn du noch neu im Training bist, solltest du das Gewicht niedriger halten, um sicherzustellen, dass du die richtige Technik verwendest und Verletzungen vermeidest. Wenn du jedoch erfahrener bist und die Technik beherrschst, kannst du möglicherweise schwerere Gewichte verwenden, um mehr Muskelreize zu erzeugen.

Insgesamt ist das Finden des individuellen richtigen Gewichts für das Hypertrophie-Training eine Kombination aus Wissen, Erfahrung und Selbstbewusstsein. Es erfordert ein Verständnis deiner persönlichen Fähigkeiten und Ziele sowie die Fähigkeit, deine Leistung zu messen und anzupassen. Die oben genannten Schritte können dir helfen, dein Trainingsgewicht zu bestimmen und sicherzustellen, dass du das Beste aus deinem Hypertrophie-Training herausholst.

Es ist auch wichtig zu beachten, dass dein Trainingsgewicht im Laufe der Zeit variieren wird, da du stärker und erfahrener wirst. Es ist wichtig, dein Gewicht regelmäßig zu überprüfen und anzupassen, um sicherzustellen, dass du weiterhin Fortschritte machst und deine Ziele erreichst.

Zusammenfassend lässt sich sagen, dass das Finden des richtigen Gewichts für das Hypertrophie-Training eine Kombination aus objektiven und subjektiven Faktoren ist. Durch das Verständnis deiner Fähigkeiten und Ziele, das Messen deiner Leistung und die Verwendung der RPE-Skala kannst du dein Trainingsgewicht optimieren und das Wachstum deiner Muskeln fördern.''',
        ["Trainingsplan", "Gewicht"]),
    Article(
        "https://images.pexels.com/photos/415779/pexels-photo-415779.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Die Rolle der Trainingsfrequenz",
        "Dieser Artikel beschreibt die Relevanz der Trainingsfrequenz für einen optimalen Trainingsplan",
        '''Trainingsfrequenz ist ein wichtiger Faktor, der beim Muskelaufbau oft unterschätzt wird. Viele Menschen denken, dass sie nur einmal pro Woche trainieren müssen, um ihre Muskeln zu stärken und zu vergrößern. In Wirklichkeit spielt die Trainingsfrequenz jedoch eine entscheidende Rolle beim Aufbau von Muskelmasse. In diesem Artikel werden wir die Relevanz von Trainingsfrequenz für den Muskelaufbau diskutieren.

Was ist Trainingsfrequenz?

Trainingsfrequenz bezieht sich auf die Anzahl der Trainingseinheiten, die du pro Woche für jede Muskelgruppe ausführst. Wenn du beispielsweise Brust, Trizeps und Schultern an einem Trainingstag trainierst, beträgt deine Trainingsfrequenz für diese Muskelgruppen einmal pro Woche. Wenn du jedoch zweimal pro Woche trainierst, kannst du die Trainingsfrequenz auf zweimal pro Woche erhöhen, indem du deine Muskelgruppen auf zwei verschiedene Trainingstage aufteilst.

Wie beeinflusst Trainingsfrequenz den Muskelaufbau?

Die Trainingsfrequenz hat einen direkten Einfluss auf den Muskelaufbau. Wenn du häufiger trainierst, kann dies zu einer besseren Proteinsynthese und einer erhöhten Muskelrekrutierung führen. Proteinsynthese ist der Prozess, bei dem dein Körper Protein aufbaut, um deine Muskeln zu stärken und zu vergrößern. Eine erhöhte Trainingsfrequenz führt auch zu einer besseren Muskelrekrutierung, was bedeutet, dass du mehr Muskelfasern aktivierst und mehr Muskelwachstum erzeugst.

Eine Studie von Grgic et al. (2018) zeigte, dass eine höhere Trainingsfrequenz mit einer größeren Zunahme der Muskelmasse verbunden ist. In der Studie untersuchten die Forscher die Auswirkungen von Trainingsfrequenz auf den Muskelaufbau bei männlichen Trainierenden. Die Teilnehmer wurden in zwei Gruppen eingeteilt: eine Gruppe trainierte jede Muskelgruppe einmal pro Woche, während die andere Gruppe jede Muskelgruppe zweimal pro Woche trainierte. Die Ergebnisse zeigten, dass die Gruppe mit höherer Trainingsfrequenz eine größere Zunahme der Muskelmasse aufwies als die Gruppe mit niedriger Trainingsfrequenz.

Eine andere Studie von Schoenfeld et al. (2016) zeigte ähnliche Ergebnisse. In der Studie wurden die Auswirkungen von Trainingsfrequenz auf den Muskelaufbau bei männlichen und weiblichen Trainierenden untersucht. Die Teilnehmer wurden in zwei Gruppen eingeteilt: eine Gruppe trainierte jede Muskelgruppe einmal pro Woche, während die andere Gruppe jede Muskelgruppe zweimal pro Woche trainierte. Die Ergebnisse zeigten, dass die Gruppe mit höherer Trainingsfrequenz eine größere Zunahme der Muskelmasse aufwies als die Gruppe mit niedriger Trainingsfrequenz.

Wie oft sollte man trainieren, um Muskeln aufzubauen?

Es gibt keine spezifische Anzahl von Trainingseinheiten, die für jeden Trainierenden am besten geeignet sind. Die Trainingsfrequenz hängt von verschiedenen Faktoren ab, wie zum Beispiel deiner Fitness, deinem Alter, deinem Trainingsziel und deinem Zeitplan. In der Regel wird jedoch empfohlen, jede Muskelgruppe mindestens zweimal pro Woche zu trainieren, um den Muskelaufbau zu maximieren.

Eine Möglichkeit, dies zu erreichen, besteht darin, einen Split-Trainingsplan zu verwenden, bei dem du verschiedene Muskelgruppen an verschiedenen Tagen trainierst. Zum Beispiel könntest du an einem Tag Brust und Trizeps trainieren und an einem anderen Tag Rücken und Bizeps. Dadurch erhöhst du deine Trainingsfrequenz für jede Muskelgruppe auf zweimal pro Woche.

Es ist auch wichtig zu beachten, dass die Trainingsfrequenz nicht das einzige Element ist, das den Muskelaufbau beeinflusst. Die Intensität und das Volumen des Trainings sowie die Ernährung spielen ebenfalls eine wichtige Rolle. Eine ausgewogene Ernährung mit ausreichend Protein, Kohlenhydraten und gesunden Fetten ist unerlässlich für den Muskelaufbau.

Fazit

Die Trainingsfrequenz ist ein wichtiger Faktor, der beim Muskelaufbau oft übersehen wird. Eine höhere Trainingsfrequenz kann zu einer besseren Proteinsynthese und Muskelrekrutierung führen, was zu einem größeren Muskelaufbau führt. Es wird empfohlen, jede Muskelgruppe mindestens zweimal pro Woche zu trainieren, um den Muskelaufbau zu maximieren. Es ist jedoch wichtig, auch auf eine ausgewogene Ernährung und ausreichende Intensität und Volumen des Trainings zu achten, um die besten Ergebnisse zu erzielen.''',
        ["Trainingsplan", "Trainingsfrequenz"]),
    Article(
        "https://images.pexels.com/photos/6389075/pexels-photo-6389075.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Die richtige Verwendung von Intensitätstechniken",
        "Dieser Artikel beschreibt wie Intensitätstechniken im Hypertophietraining richtig verwendet werden können, um einen maximalen Muskelreiz setzen zu können",
        '''Intensitätstechniken sind eine beliebte Methode im Hypertrophie-Training, um die Muskeln über die Grenzen hinaus zu belasten und ein maximales Wachstum zu erreichen. Diese Techniken sind effektiv, weil sie die Muskelfasern überlasten und die Wiederholungen und Sätze in einer einzigen Trainingseinheit maximieren. In diesem Artikel werden wir uns näher mit Intensitätstechniken im Hypertrophie-Training befassen und erläutern, wie sie angewendet werden.

Was sind Intensitätstechniken?

Intensitätstechniken sind Trainingsmethoden, bei denen du deine Muskeln auf eine andere Art und Weise belastest, um ein höheres Maß an Intensität und Stress auf den Muskel zu erzeugen. Diese Techniken umfassen Drop-Sets, Supersätze, Negativwiederholungen, Teilwiederholungen und viele weitere. Durch die Verwendung von Intensitätstechniken kannst du die Anzahl der Wiederholungen und Sätze in einer einzigen Trainingseinheit maximieren und dadurch ein höheres Maß an Muskelwachstum erreichen.

Wie funktionieren Intensitätstechniken?

Intensitätstechniken funktionieren, indem sie die Muskelfasern auf eine andere Art und Weise belasten als herkömmliche Wiederholungen. Drop-Sets zum Beispiel funktionieren, indem du das Gewicht nach jeder abgeschlossenen Wiederholung reduzierst, um den Muskel weiter zu belasten und mehr Wiederholungen durchzuführen. Supersätze hingegen funktionieren, indem du zwei Übungen ohne Pause hintereinander ausführst, um den Muskel maximal zu belasten.

Wie wendet man Intensitätstechniken im Hypertrophie-Training an?

Intensitätstechniken können auf verschiedene Arten und Weisen angewendet werden. Du kannst sie in dein reguläres Hypertrophie-Training einbauen oder sie als eigenständige Trainingseinheit verwenden. Beispielsweise kannst du einen Satz reguläre Wiederholungen mit einem Satz Drop-Sets oder Supersätzen kombinieren, um das Training intensiver zu gestalten.

Eine andere Möglichkeit, Intensitätstechniken anzuwenden, besteht darin, sie während der letzten Sätze einer Übung einzusetzen. Wenn du beispielsweise Bankdrücken ausführst, kannst du die letzten zwei Sätze mit Negativwiederholungen oder Teilwiederholungen ausführen, um den Muskel zu überlasten und mehr Wachstum zu erzielen.

Welche Vorteile haben Intensitätstechniken?

Intensitätstechniken haben mehrere Vorteile im Hypertrophie-Training. Sie ermöglichen es, die Anzahl der Wiederholungen und Sätze in einer einzigen Trainingseinheit zu maximieren, um den Muskel maximal zu belasten. Dadurch wird ein höheres Maß an Muskelwachstum erreicht. Außerdem können Intensitätstechniken die Plateaus durchbrechen, die oft bei regelmäßigem Training auftreten.

Fazit

Intensitätstechniken sind eine effektive Methode im Hypertrophie-Training, um die Muskeln maximal zu belasten und ein höheres Maß an Muskelwachstum zu erreichen. Durch die Verwendung von Techniken wie Drop-Sets, Supersätzen, Negativwiederholungen und Teilwiederholungen können die Muskelfasern überlastet werden, um ein höheres Wachstum zu erzielen. Es ist wichtig zu beachten, dass Intensitätstechniken nur in Maßen eingesetzt werden sollten, da sie sehr anstrengend sind und das Risiko von Verletzungen erhöhen können, wenn sie zu oft und zu intensiv eingesetzt werden. Es ist auch wichtig, eine gute Form beizubehalten und das Gewicht angemessen zu wählen, um Verletzungen zu vermeiden.

Wenn du Intensitätstechniken in dein Hypertrophie-Training einbauen möchtest, solltest du sie langsam und schrittweise einführen. Beginne mit einer Technik und erhöhe dann allmählich die Intensität, indem du mehr Sätze oder Wiederholungen hinzufügst. Achte darauf, deinen Körper angemessen zu erholen, indem du genügend Schlaf bekommst und dich ausreichend ernährst, um das Wachstum und die Regeneration deiner Muskeln zu unterstützen.

Zusammenfassend können Intensitätstechniken ein wertvolles Werkzeug im Hypertrophie-Training sein, um das Muskelwachstum zu maximieren und Plateaus zu durchbrechen. Es ist jedoch wichtig, sie verantwortungsbewusst und mit Vorsicht einzusetzen, um Verletzungen zu vermeiden und das beste Ergebnis zu erzielen.''',
        ["Intensitätstechniken", "Training"]),
    Article(
        "https://images.pexels.com/photos/6307/desk-white-design-quote.jpg?auto=compress&cs=tinysrgb&w=600",
        "Muskelaufbau durch Intensitätsreduzierung",
        "Dieser Artikel beschreibt die Rolle von Deloads im Hypertrohpie-Training.",
        '''Deload ist eine Strategie im Kraftsport, die von vielen Trainern und Athleten verwendet wird, um die Leistung und das Muskelwachstum zu verbessern und Verletzungen zu vermeiden. Der Begriff Deload bezieht sich auf eine Phase, in der die Trainingsintensität und -volumen reduziert werden, um dem Körper eine Chance zur Erholung und Regeneration zu geben.

Warum Deload im Kraftsport wichtig ist

Im Kraftsport führen wir oft sehr anspruchsvolle Übungen aus, die eine hohe Belastung für den Körper darstellen. Regelmäßiges Training führt dazu, dass sich der Körper an diese Belastung anpasst und stärker wird. Wenn wir jedoch kontinuierlich mit maximaler Intensität und Volumen trainieren, können wir uns erschöpfen und anfälliger für Verletzungen werden. Dies ist, wo Deload ins Spiel kommt.

Indem wir das Volumen und die Intensität des Trainings reduzieren, geben wir unserem Körper die Zeit, die er benötigt, um sich zu erholen und sich an die Belastung anzupassen. Deload kann auch dazu beitragen, Verletzungen zu vermeiden, indem es unserem Körper die Möglichkeit gibt, mögliche Verletzungen zu reparieren und zu heilen, bevor sie zu größeren Problemen werden.

Wann Deload im Kraftsport durchgeführt werden sollte

Es gibt keine feste Regel, wann eine Deload-Phase durchgeführt werden sollte, da dies von Person zu Person und von Training zu Training unterschiedlich sein kann. Einige Anzeichen dafür, dass es Zeit für eine Deload-Phase sein könnte, sind:

Ein Plateau in der Leistung oder im Muskelwachstum
Müdigkeit und Erschöpfung, die sich auch nach dem Training nicht bessern
Verletzungsanfälligkeit oder Schmerzen
Mangelnde Motivation oder Interesse am Training
Eine Deload-Phase sollte jedoch nicht als Entschuldigung genutzt werden, um das Training auszulassen oder zu vernachlässigen. Es ist wichtig, weiterhin aktiv zu bleiben und sich auf andere Aspekte des Trainings zu konzentrieren, wie z.B. die Technik oder die Ernährung.

Wie eine Deload-Phase im Kraftsport durchgeführt werden sollte

Eine typische Deload-Phase dauert in der Regel etwa eine Woche und beinhaltet eine Reduzierung des Trainingsvolumens und der Intensität um etwa 40-60%. Dies bedeutet, dass Sie weniger Sätze und Wiederholungen durchführen und mit geringerem Gewicht arbeiten sollten. Es ist wichtig zu beachten, dass Sie während dieser Phase nicht einfach untätig herumsitzen sollten. Sie sollten weiterhin aktiv bleiben und sich auf andere Aspekte des Trainings konzentrieren, wie z.B. die Verbesserung der Technik oder die Stärkung von schwächeren Muskeln.

Deload kann auch durch eine Änderung der Trainingsform oder der Übungen erreicht werden. Zum Beispiel kann ein Kraftsportler, der normalerweise schwere Kniebeugen durchführt, während einer Deload-Phase leichtere Kniebeugen oder eine andere Übung wie Lunges oder Split Squats ausprobieren.

Fazit

Deload ist eine wichtige Strategie im Kraftsport, um Verletzungen zu vermeiden, die Leistung und das Muskelwachstum zu verbessern und dem Körper die Zeit zu geben, sich zu erholen und anzupassen. Eine Deload-Phase sollte jedoch nicht als Entschuldigung genutzt werden, um das Training auszulassen oder zu vernachlässigen. Es ist wichtig, weiterhin aktiv zu bleiben und sich auf andere Aspekte des Trainings zu konzentrieren, um sicherzustellen, dass man nicht den Fortschritt verliert, den man durch kontinuierliches Training erreicht hat.

Es ist auch wichtig zu beachten, dass Deload-Phasen nicht für jeden Athleten oder jedes Training notwendig sind. Wenn Sie Fortschritte machen und keine Anzeichen von Erschöpfung oder Verletzungen haben, ist es möglicherweise nicht notwendig, eine Deload-Phase einzulegen. Sie sollten jedoch Ihre körperliche Verfassung und Ihren Trainingsplan regelmäßig überwachen, um sicherzustellen, dass Sie das Beste aus Ihrem Training herausholen und Verletzungen vermeiden.

Insgesamt ist Deload eine wichtige Strategie im Kraftsport, die dazu beitragen kann, Verletzungen zu vermeiden, die Leistung und das Muskelwachstum zu verbessern und den Körper zu erholen und anzupassen. Durch eine regelmäßige Überwachung Ihres Trainingsplans und Ihrer körperlichen Verfassung können Sie entscheiden, ob eine Deload-Phase für Sie notwendig ist und wie Sie diese am besten durchführen können, um das Beste aus Ihrem Training herauszuholen.''',
        ["Regeneration", "Deload", "Intensität"]),
    Article(
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Die richtige Ernährung",
        "Dieser Artikel beschreibt die Grundlagen für die richtige Ernährung, um maximalen Muskelaufbau ermöglichen zu können",
        '''Die richtige Ernährung spielt eine entscheidende Rolle beim Muskelaufbau. Ohne die richtige Ernährung wird es schwierig sein, die gewünschten Ergebnisse zu erzielen, da das Muskelwachstum von der richtigen Kombination aus Training und Ernährung abhängt. Hier sind einige Tipps für eine optimale Ernährung für maximalen Muskelaufbau.

Proteine

Proteine sind die Bausteine von Muskeln, daher ist es wichtig, ausreichend Protein zu konsumieren, um Muskelwachstum und Reparatur zu fördern. Die empfohlene tägliche Proteinmenge für aktive Erwachsene beträgt etwa 1,5 bis 2,2 Gramm pro Kilogramm Körpergewicht. Es ist wichtig, auf eine gute Proteinqualität zu achten, indem man auf Vollwertkost wie Hühnchen, Truthahn, Rindfleisch, Fisch, Eier, Milchprodukte, Hülsenfrüchte und Sojaprodukte zurückgreift.

Kohlenhydrate

Kohlenhydrate sind eine wichtige Energiequelle für das Training und helfen dabei, Glykogen in den Muskeln zu speichern. Dies kann dazu beitragen, dass man länger und intensiver trainieren kann, was wiederum zu einem besseren Muskelaufbau führt. Es ist wichtig, komplexe Kohlenhydrate aus Vollkornprodukten, Obst, Gemüse und Hülsenfrüchten zu wählen und zuckerhaltige Lebensmittel und Getränke zu vermeiden.

Fette

Obwohl es wichtig ist, die Aufnahme von gesättigten und trans-Fetten zu begrenzen, sind gesunde Fette aus Nüssen, Samen, Avocado und Fisch wichtig für den Muskelaufbau und die allgemeine Gesundheit. Fette spielen eine wichtige Rolle bei der Regulierung des Hormonspiegels und der Entzündungsreaktionen, die für das Muskelwachstum entscheidend sind.

Mahlzeitenplanung

Es ist wichtig, regelmäßig zu essen und die Mahlzeiten auf den Tag verteilt zu halten, um den Muskelwachstum zu fördern. Es wird empfohlen, alle drei bis vier Stunden eine Mahlzeit oder einen Snack zu sich zu nehmen, um den Körper mit ausreichend Energie und Nährstoffen zu versorgen.

Ergänzungen

Nahrungsergänzungsmittel können eine wertvolle Ergänzung zur Ernährung sein, sollten aber nicht als Ersatz für eine ausgewogene Ernährung betrachtet werden. Kreatin, EAAs und Whey-Protein sind einige der beliebtesten Ergänzungen für den Muskelaufbau.

Zusammenfassung

Die richtige Ernährung ist entscheidend für den Muskelaufbau. Es ist wichtig, ausreichend Protein, komplexe Kohlenhydrate und gesunde Fette zu konsumieren und regelmäßig zu essen. Nahrungsergänzungsmittel können eine Ergänzung zur Ernährung sein, sollten aber nicht als Ersatz für eine ausgewogene Ernährung betrachtet werden. Eine ausgewogene Ernährung und ein effektives Trainingsprogramm können zusammen helfen, den Muskelaufbau zu fördern und die Ergebnisse zu maximieren.

Wichtig ist auch, auf ausreichend Wasserzufuhr zu achten, da Wasser für den Transport von Nährstoffen und Sauerstoff zu den Muskeln benötigt wird und auch für den Abtransport von Abfallprodukten verantwortlich ist.

Es ist auch wichtig, den individuellen Kalorienbedarf zu berücksichtigen und entsprechend anzupassen. Wenn man mehr Kalorien zu sich nimmt, als man verbraucht, kann dies zu einer Gewichtszunahme führen, die auch Muskelmasse beinhaltet. Wenn man jedoch weniger Kalorien zu sich nimmt, als man verbraucht, kann dies zu einer Gewichtsabnahme führen, einschließlich des Verlusts von Muskelmasse. Eine individuelle Beratung durch einen Ernährungsexperten kann dabei helfen, den individuellen Kalorienbedarf und die Nährstoffzufuhr zu bestimmen.

Zusammenfassend kann gesagt werden, dass eine ausgewogene Ernährung, die ausreichend Protein, komplexe Kohlenhydrate, gesunde Fette und ausreichend Wasser enthält, eine wichtige Rolle beim Muskelaufbau spielt. Es ist auch wichtig, regelmäßig zu essen und den individuellen Kalorienbedarf zu berücksichtigen. Nahrungsergänzungsmittel können eine wertvolle Ergänzung zur Ernährung sein, sollten aber nicht als Ersatz für eine ausgewogene Ernährung betrachtet werden. Eine individuelle Beratung durch einen Ernährungsexperten kann dabei helfen, den individuellen Bedarf zu bestimmen und das beste Ergebnis beim Muskelaufbau zu erreichen.''',
        ["Ernährung", "Muskelaufbau", "Supplements"])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Icon(actions: const []),
      body: ListView(
        shrinkWrap: true,
        children: [
          for (var article in articles)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.65),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleView(article: article)));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text(article.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall)),
                            Divider(
                                color: Theme.of(context).primaryColor,
                                endIndent: 0),
                            Row(children: <Widget>[
                              Flexible(
                                  flex: 4,
                                  fit: FlexFit.tight,
                                  child: Center(
                                    child: Image.network(article.picture),
                                  )),
                              Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    article.description,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ]),
                            Divider(
                                color: Theme.of(context).primaryColor,
                                endIndent: 0),
                            MultiSelectChipDisplay(
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                items: article.tags
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList())
                          ],
                        )),
                  )),
            ),
        ],
      ),
    );
  }
}
