Content-Type: multipart/mixed; boundary="===============8507958496400223108=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 02/11] eap: Re-send Identity Request on EAPoL-Start
Date: Fri, 28 Aug 2020 01:24:39 +0200
Message-ID: <CAOq732LnFsa60y9z4LWfo68N8azW1Omn-o4XHfWqemod8hkjGA@mail.gmail.com>
In-Reply-To: <2dcc54ae-5179-d289-12a1-c99604d70311@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8507958496400223108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 22:52, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/27/20 3:47 PM, Andrew Zaborowski wrote:
> > On Thu, 27 Aug 2020 at 20:55, Denis Kenzior <denkenz@gmail.com> wrote:
> >> By the way, there are several implementations (Apple AirPort for examp=
le) that
> >> do not start WSC until an EAPoL-Start is sent.  I don't recall that EA=
PoL-Start
> >> behavior was specified in WSC 1.0.  I know that one of my routers that=
 uses WSC
> >> 2.0 doesn't do this and sends a RequestIdentity right away.  So that m=
ight
> >> explain what you're seeing here.
> >
> > So I intended to mention this separately but the spec recommends that
> > we send the EAP Identity request automatically if the enrollee is WSC
> > 2.0 and it prohibits us doing this if it's WSC 1.0.  I think there's
> > probably no harm trying it until we see it throws off some device.
>
> Okay.  So if the spec recommends this, it probably is intentional.  May b=
e a
> good idea to follow its recommendation.

Ok.

> Do you recall where this is stated?

In 8.2:
"On successful association, the station will then send an EAPOL-Start
to the AP and wait
for EAP-Request/Identity. The AP is allowed to send
EAP-Request/Identity to the station
before EAPOL-Start is received if a WSC IE is included in the
(re)association request
and the WSC IE is version 2.0 or higher."

Also here's the other compatibility bit I mentioned, which I'm not
honoring for the moment:
"Note: For backwards compatibility with version 1.0 implementations an
AP hosting a
WPA2-Personal network and supporting WSC would need to permit the associati=
on
exchange with a station intending to engage in EAP-WSC where there is
no RSN IE or
WPA IE in the association request frames even if there is no WSC IE
either. The AP
shall only permit the exchange of EAP-WSC messages with a station that
associates in
this manner and only after receiving the EAPOL-Start frame. The WSC IE
may or may
not be present in the association requests from WSC version 1.0 devices."

Best regards
--===============8507958496400223108==--

