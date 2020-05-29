Content-Type: multipart/mixed; boundary="===============4517763501164323608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] anqp: refactor to use frame-xchg
Date: Fri, 29 May 2020 11:13:41 -0500
Message-ID: <7a5c93e8-0a52-48da-36d3-80eb6cff6d38@gmail.com>
In-Reply-To: <cc0280b8867ed533e6cdcb06bbf38ea5647bdc91.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4517763501164323608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Well, can't we just check if anqp is pending for the network inside
>> network_connect() or so, and if it is, defer taking any action until
>> anqp succeeds / fails?
> =

> Checking for pending is easy, defering is the hard part. We could set a
> flag in network if ANQP is pending, then if/when the network info gets
> set by station we could attempt a connect then (basically from inside
> network_set_info). But I have a feeling you wont like this, it just
> feels wrong.

Well we have to communicate between the two modules somehow.

> =

> Then a further issue is how do we ultimately decide when to fail with
> NotConfigured if ANQP fails or there is an error? Unless we add some
> other mechanism for station to signal that ANQP failed like
> network_set_info_failed(). Again doesn't really feel right.

So one thing we could do is to have network actually drive the anqp =

queries.  Might be what we want to do anyway since we actually should be =

doing multiple queries for grabbing icons, etc.  The scanning suspension =

and resumption of auto-connect is the only tricky part.  Perhaps we just =

have a reference count or something on the anqp request and station can =

kick off autoconnect when that reaches 0.

> =

> Maybe a per-station watch for ANQP that network can subscribe to?
> Network could get notified both if ANQP is being performed and when it
> finished.

Or something like this, yes.

Regards,
-Denis
--===============4517763501164323608==--

