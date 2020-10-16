Content-Type: multipart/mixed; boundary="===============3082656036980332522=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: iwd problems on Arch Linux
Date: Fri, 16 Oct 2020 09:16:36 +0200
Message-ID: <20201016071636.etikl2nmzrxeb2ri@beryllium.lan>
In-Reply-To: <00f42112-bad0-9140-9d33-f94f309fa910@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3082656036980332522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 02:58:04PM -0500, Denis Kenzior wrote:
> As I've said before, connman is invoking Station.Disconnect which prevents
> iwd from reconnecting autonomously.  There's really nothing we can do abo=
ut
> that. Any issues are likely in connman.git/plugins/iwd.c

Does Station.Disconnect and AutoConnect=3Dfalse disable the iwd's scan
engine? The pluning relies on getting SSIDs updates.
--===============3082656036980332522==--

