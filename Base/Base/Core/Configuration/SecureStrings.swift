//
//
//  SecureStrings.swift
//
//  Created by Mark Evans on 2/22/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

@objc public class SecureStrings: NSObject {
    
    let ApiLiveHost = "h".t.t.p.s.colon.forward_slash.forward_slash.a.p.i.dot.f.a.n.a.m.a.n.a.dot.c.o.m // LIVE
    let ApiDevHost = "h".t.t.p.s.colon.forward_slash.forward_slash.a.p.i.dash.d.e.v.dot.f.a.n.a.m.a.n.a.dot.c.o.m // DEV
    let ApiVersion = "v"._1
    let ApiClientId = "I".O.S.A.p.p
    let ApiClientSecret = "4".r.Y.d.C.M.S.S.K.q._3._3.i.e.o.r
    let PlayPusherClientIdDev = "F".a.n.a.m.a.n.a.underscore.D.e.v.e.l.o.p.m.e.n.t.underscore.M.o.b.i.l.e.S.D.K.underscore._6 // DEV
    let PlayPusherClientId = "F".a.n.a.m.a.n.a.underscore.P.r.o.d.u.c.t.i.o.n.underscore.M.o.b.i.l.e.S.D.K.underscore._8 // PROD
    let PlayPusherClientSecretDev = "N".h.O.G.c.Z.S.Z.q.V.z.s.J.Q.F.g // DEV
    let PlayPusherClientSecret = "b".F._1.h.g.T.k.i._6._4.E.e.W.h.s._8 // PROD
    let TrashTalkerLiveKey = "2"._9._0._4.B._5._5.C.dash._8.D._9._7.dash._4.D._0._3.dash.B._8.E.E.dash.E._5.A.B.C.B._0._6._4._0._9._9
    let TrashTalkerDevKey = "3".A.A._9._6.D._3._3.dash._7._9.D._7.dash._4.B._1._7.dash._8.C.D._7.dash._9.D.C._6._9.F.E._8.E._9._5._3
    let PayPalLiveKey = "A".T._7.b.d.B.C.d.dash.z.r.p.z.w.H.e.Q._6.u.P.d.d.H.T.p.a.f.g.R.M.G.A.B.n.H.i.Y.u.g.s.s._7.p.a.V.Z.R.a.L.G.J.A.b.t.T._9.p.I.v.F
    let PayPalDevKey = "A".W.K.u.l.x.C.M.O.X.U.o._2.u.h.u.l.I.k.M.A.D.D.A.K.P.v.L.z.R.b.o.T.O._5.s.N.S.y.dash.h.K.V.L.t.r.dash._9.C.i.G.g._0._3.h.U.F.C.c.s
    let GoogleAnalyticsKey = "U".A.dash._3._7._4._4._0._2._6._7.dash._2
    let LocalyticsKey = "2"._6._3._9._0._4._7._9.e._7.c.c._2.e._7._1._1.c._5._8.b.e.d.dash._4._6._6._3._2.b._8._0.dash.f._4._8._2.dash._1._1.e._6.dash.f._7._6._7.dash._0._0._5._8.d._5._2._6._9._8._1.b // DEV

    static let shared: SecureStrings = {
        let instance = SecureStrings()
        return instance
    }()

}
