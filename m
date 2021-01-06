Content-Type: multipart/mixed; boundary="===============3499016385237034755=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] Diagnostic Interface
Date: Wed, 06 Jan 2021 12:23:54 -0800
Message-ID: <20210106202355.103284-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3499016385237034755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This interface would expose details are may be too low level for a
general purpose application, like a connection manager. Some of these
details are useful though and these will go into this new diagnostic
interface. This interface is also going to be very useful in the
autotesting framework.

The GetDiagnostics() method is somewhat mapped to GET_STATION in
nl80211. Some of these values are too volatile to express as properties
as they change frequently so an application may get them at the time
they are needed.

The additional properties would be purely for autotesting/debugging.

James Prestwood (1):
  diagnostic: DBus interface definition

 doc/diagnostics.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 doc/diagnostics.txt

-- =

2.26.2

--===============3499016385237034755==--

