Content-Type: multipart/mixed; boundary="===============3752497502171080094=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] main: Add D-Bus Daemon.GetInfo method
Date: Wed, 05 May 2021 10:43:37 +0200
Message-ID: <29F0C8A8-AB3D-44ED-8943-94A0BE763F3D@holtmann.org>
In-Reply-To: <20210430220124.3013086-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3752497502171080094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Expose the state directory/storage directory path on D-Bus because it
> can't be known to clients until IWD runs, and client might need to
> occasionally fiddle with the network config files.  While there also
> expose the IWD version string, similar to how some other D-Bus services
> do.
> ---
> I'm not happy with the name of the interface and the name of the method
> but couldn't find better names that would work well and satisfy
> everybody.  "net.connman.IWD" or "net.connman.iwd.Control" are other
> names I considered, and as for GetInfo the alternative could be using
> properties similar to how org.freedesktop.NetworkManager exposes
> Version, org.freedesktop.ColorManager exposes DaemonVersion,
> org.gnome.DisplayManager exposes Version{Major,Minor,Micro}, etc.
> ---

so I am actually fine with the naming. Lets use net.connman.iwd.Daemon.GetI=
nfo() and StateDirectory and Version as you have in this patch. Just also d=
ocument it in doc/daemon-api.txt as well and then we can merge this.

Regards

Marcel

--===============3752497502171080094==--

