Content-Type: multipart/mixed; boundary="===============3467633474621696143=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] main: Add D-Bus Daemon.GetInfo method
Date: Fri, 07 May 2021 08:44:53 -0500
Message-ID: <463c8450-4ba1-6ade-fac5-03b09e4ae8a1@gmail.com>
In-Reply-To: <20210506212828.79315-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3467633474621696143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/6/21 4:28 PM, Andrew Zaborowski wrote:
> Expose the state directory/storage directory path on D-Bus because it
> can't be known to clients until IWD runs, and client might need to
> occasionally fiddle with the network config files.  While there also
> expose the IWD version string, similar to how some other D-Bus services
> do.
> ---
>   src/dbus.h |  1 +
>   src/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)
> =


Both applied, thanks.

Regards,
-Denis

--===============3467633474621696143==--

