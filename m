Content-Type: multipart/mixed; boundary="===============5309688882686460558=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/7] Fixes: 6e8b7652788ac (add check for
 CMD_AUTH/CMD_ASSOC support)
Date: Tue, 30 Mar 2021 17:33:01 -0500
Message-ID: <eeea611f-b3b0-e5ae-a440-27757dc0422f@gmail.com>
In-Reply-To: <20210330210921.750967-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5309688882686460558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/30/21 4:09 PM, James Prestwood wrote:
> Commit 6e8b76527 added a switch statement for AKM suites which
> was not correct as this is a bitmask and may contain multiple
> values. Intead we can rely on wiphy_select_akm which is a more
> robust check anyways.

Fixes: is used as a tag, not a commit header.  Linux Kernel uses a special =

format for that, which we should do as well.

Just add this to your .git/config

[pretty]
         fixes =3D Fixes: %h (\"%s\")


And you can use git show --pretty=3Dfixes 6e8b76527 to have it print in the=
 right =

format.

> ---
>   src/wiphy.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> =

> v3:
>   * Return the result of wiphy_select_akm
>   * Pass false for fils_hint parameter
> =


I fixed up the commit description and applied, thanks.

Regards,
-Denis
--===============5309688882686460558==--

