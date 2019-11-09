Content-Type: multipart/mixed; boundary="===============3120398025401948257=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH_5/5=5D_client=3A_Fail_in_non-interactive_mode_if?=
 =?utf-8?q?_iwd_service_isn=E2=80=99t_running?=
Date: Fri, 08 Nov 2019 21:22:58 -0600
Message-ID: <be2d2661-dc3f-3419-de94-3a7eb5ac9175@gmail.com>
In-Reply-To: <20191108193223.1950-5-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3120398025401948257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 11/8/19 1:32 PM, Tim Kourt wrote:
> In non-interactive mode request the managed object right away and do
> not wait for the service to appear. This way client can fail right
> away instead of endlessly waiting in non-interactive mode.
> ---
>   client/dbus-proxy.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3120398025401948257==--

