import Foundation
import UIKit

struct PhotoOfTheDay: Codable {
    let title: String
    let explanation: String
    let url: URL?
    let copyright: String?
    let date: String
    
    // empty initialiser for a default photo of the day
    init() {
        self.title = "A Phoenix Aurora over Iceland"
        self.explanation = " All of the other aurora watchers had gone home. By 3:30 am in Iceland, on a quiet September night, much of that night's auroras had died down. Suddenly, unexpectedly, a new burst of particles streamed down from space, lighting up the Earth's atmosphere once again. This time, surprisingly, pareidoliacally, the night lit up with an amazing shape reminiscent of a giant phoenix. With camera equipment at the ready, two quick sky images were taken, followed immediately by a third of the land. The mountain in the background is Helgafell, while the small foreground river is called Kaldá, both located about 30 kilometers north of Iceland's capital Reykjavík. Seasoned skywatchers will note that just above the mountain, toward the left, is the constellation of Orion, while the Pleiades star cluster is also visible just above the frame center. The 2016 aurora, which lasted only a minute and was soon gone forever -- would possibly be dismissed as an fanciful fable -- were it not captured in the featured, digitally-composed, image mosaic."
        self.date = "2021-01-03"
        self.url = nil
        self.copyright = "Hallgrimur P. Helgason"
    }
}
