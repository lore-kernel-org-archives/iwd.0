Content-Type: multipart/mixed; boundary="===============1993982404785459589=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/16] hwsim: return radio ID on create
Date: Thu, 27 Aug 2020 15:08:35 -0500
Message-ID: <d4772e1e-cf43-0d33-4d0b-3aa8fa468fca@gmail.com>
In-Reply-To: <20200827173229.26466-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1993982404785459589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/27/20 12:32 PM, James Prestwood wrote:
> Hwsim was relying on some internal behavior of mac80211_hwsim where new
> radios are created with ID's starting at zero and incremented. While
> this is a reasonable assumption its better to obtain the actual radio
> ID since mac80211_hwsim returns it in the radio creation callback.
> =

> Now hwsim will return the radio ID when creating radios. Negative returns
> are still errors, but any value >=3D 0 indicates the radio ID of the newly
> created radio.

Ah, now I see what you meant by exit code.  Sorry I should have caught this=
 earlier.

So the problem is that UNIX doesn't really understand negative exit codes. =
 exit =

code of 0 is a success and anything else is a failure.

I think you will get people screaming obscenities if they try to use hwsim =
in a =

script...

> ---
>   tools/hwsim.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> =


Regards,
-Denis
--===============1993982404785459589==--

