Content-Type: multipart/mixed; boundary="===============0635294715031279091=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: fix Radio/Interface circular reference
Date: Tue, 03 Nov 2020 13:57:54 -0600
Message-ID: <18af922a-3eba-dc01-0fb9-ecbe96c1481c@gmail.com>
In-Reply-To: <20201103170306.2653870-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0635294715031279091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/3/20 11:03 AM, James Prestwood wrote:
> Code was added with commit 04487f575b6 which passes a radio object
> to the Interface class constructor and stores it in the Interface
> object. The radio class also stores each Interface object which
> creates a circular reference and causes the Radio to stick around
> long after the tests finishes.
> =

> I cannot see why the Interface needs to keep track of the Radio
> object. None of the wpa_supplicant utilities use this so it has
> been removed.
> ---
>   tools/test-runner | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0635294715031279091==--

