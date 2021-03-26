Content-Type: multipart/mixed; boundary="===============7136180501600761155=="
MIME-Version: 1.0
From: Yuri D'Elia <wavexx@thregr.org>
Subject: iwctl force autoconnect
Date: Fri, 26 Mar 2021 22:28:45 +0100
Message-ID: <87blb5o5ro.fsf@wavexx.thregr.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7136180501600761155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is it possible to force iwd to connect to a known network without
explicitly giving a network name? That is, to force attempting to
autoconnect?

Currently "station <net> connect" requires a ssid. It would be nice if
that would be made optional, causing iwd to go through the automatic
connect logic.

I assumed that issuing a "station <net> scan" *would* attempt to
autoconnect if a known network is seen and we're currently disconnected,
but it's not always the case. If we disconnected from a known network
due to AP disappearing and reappearing sometime later, "scan" will the
network, but connection is still performed after some longer timeout.

I want to bind an action to force a scan+connect without having to wait,
and without having to hardcode a network name. When I'm moving a laptop
between offices and go through some blind spots (elevator) I end-up in a
situation where I'm disconnected, and I want to force a connection right
away.
--===============7136180501600761155==--

