Content-Type: multipart/mixed; boundary="===============8607026411759930154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-runner: fix test skipping
Date: Fri, 13 Aug 2021 16:45:01 -0500
Message-ID: <5ae61407-a99a-99cb-3e27-9c14727068f3@gmail.com>
In-Reply-To: <20210813214926.813767-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8607026411759930154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/13/21 4:49 PM, James Prestwood wrote:
> Tests that called skipTest would result in an exception which would
> hault execution as it was uncaught. In addition this wouldn't result
> in an skipped test.
> =

> Now the actual test run is surrounded in a try/except block, skipped
> exceptions are handled specifically, and a stack trace is printed if
> some other exception occurs.
> ---
>   tools/test-runner | 48 +++++++++++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> =


All applied, thanks

Regards,
-Denis
--===============8607026411759930154==--

