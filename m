Content-Type: multipart/mixed; boundary="===============4442879737338949509=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] Allow SignalLevelAgent method calls in dbus policy
Date: Fri, 20 May 2022 14:51:27 -0500
Message-ID: <43a5daae-2823-afeb-9e13-ffd79aa2f45c@gmail.com>
In-Reply-To: 20220520184857.9451-1-jesse@twosheds.org

--===============4442879737338949509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/20/22 13:48, Jesse Lentz wrote:
> The SignalLevelAgent API is currently broken by the system bus's
> security policy, which blocks iwd's outgoing method call messages. This
> patch punches a hole for method calls on the
> net.connman.iwd.SignalLevelAgent interface.
> ---
>   src/iwd-dbus.conf | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4442879737338949509==--

