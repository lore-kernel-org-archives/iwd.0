Content-Type: multipart/mixed; boundary="===============0561033189207026831=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] Fix DBus auth issues on Fedora
Date: Tue, 24 Mar 2020 13:29:00 -0700
Message-ID: <20200324202901.26984-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0561033189207026831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This 'fixes' test-runner DBus auth issues on Fedora and
maybe other system. I say 'fixes' because all its doing
is allowing anonymous access to the bus vs finding a
solution to the real problem. I (and I believe Andrew)
have been carrying similar patches in order to get
test-runner to work on Fedora.

I have tried diagnosing this without any success. Since
this is only for use in test-runner I thought a
solution (at least temporarily) would be to allow
anonymous access to DBus.

OR maybe someone will see this and have some idea as
to what is going on.

James Prestwood (1):
  test-runner: allow anonymous Dbus access

 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

-- =

2.21.1

--===============0561033189207026831==--

