Content-Type: multipart/mixed; boundary="===============8179184558526742734=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/1] Work around hanging ofono
Date: Tue, 16 Jun 2020 09:32:28 -0700
Message-ID: <20200616163229.14429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8179184558526742734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not sure if anyone else has experienced this, but occationally any
of the tests using ofono will hang on exit. I traced this into glib
waiting for something, but that something never happens. The test
itself is executing fine and successful but ofono seems to not want
to exit gracefully. It looks to be timing dependent as it rarely
happens, and when it does adding a debug print or any other code
usually makes it go away. Even this patch itself made the issue
'go away' for me.

Obviously the proper fix is figuring out where the race condition
is in ofono, but I also think having an ultimate timeout on
kill_process() would be useful which is what this patch is adding.

James Prestwood (1):
  test-runner: use WNOHANG option waiting for PID

 tools/test-runner.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- =

2.21.1

--===============8179184558526742734==--

