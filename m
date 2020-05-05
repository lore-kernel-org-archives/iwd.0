Content-Type: multipart/mixed; boundary="===============2980156468738762707=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-runner: run iwmon per-subtest
Date: Tue, 05 May 2020 16:19:43 +0000
Message-ID: <1ff14630-9a93-b7c9-7233-46b628bf0c0c@gmail.com>
In-Reply-To: <20200505160318.26419-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2980156468738762707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/5/20 11:03 AM, James Prestwood wrote:
> Previously iwmon was running per-test, which would jumble any subtests
> together into the same log file making it hard to parse. Now create
> a separate directory for each subtest and put the monitor log and
> pcap there.
> ---
>   tools/test-runner.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============2980156468738762707==--

