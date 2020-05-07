Content-Type: multipart/mixed; boundary="===============8256201359229760039=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] auto-t: add optional scan argument to
 get_ordered_network(s)
Date: Thu, 07 May 2020 18:09:15 +0000
Message-ID: <0a35ae14-fbcf-81fa-7d96-d624b3e12fea@gmail.com>
In-Reply-To: <20200506213215.17533-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8256201359229760039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/6/20 4:32 PM, James Prestwood wrote:
> There is a very common block of code inside many autotests
> which goes something like:
> =

> device.scan()
> condition =3D 'obj.scanning'
> wd.wait_for_object_condition(device, condition)
> condition =3D 'not obj.scanning'
> wd.wait_for_object_condition(device, condition)
> network =3D device.get_ordered_network('an-ssid')
> =

> When you see the same pattern in nearly all the tests this shows
> we need a helper. Basic autotests which merely check that a
> connection succeeded should not need to write the same code again
> and again. This code ends up being copy-pasted which can lead to
> bugs.
> =

> There is also a code pattern which attempts to get ordered
> networks, and if this fails it scans and tries again. This, while
> not optimal, does prevent unneeded scanning by first checking if
> any networks already exist.
> =

> This patch solves both the code reuse issue as well as the recovery
> if get_ordered_network(s) fails. A new optional parameter was
> added to get_ordered_network(s) which is False by default. If True
> get_ordered_network(s) will perform a scan if the initial call
> yields no networks. Tests will now be able to simply call
> get_ordered_network(s) without performing a scan before hand.
> ---
>   autotests/util/iwd.py | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============8256201359229760039==--

