Content-Type: multipart/mixed; boundary="===============6290927424670908998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd problems on Arch Linux
Date: Fri, 16 Oct 2020 11:00:32 -0500
Message-ID: <695a2b81-db6f-b22f-3be0-e4476275f39b@gmail.com>
In-Reply-To: <20201016071636.etikl2nmzrxeb2ri@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6290927424670908998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 10/16/20 2:16 AM, Daniel Wagner wrote:
> On Thu, Oct 15, 2020 at 02:58:04PM -0500, Denis Kenzior wrote:
>> As I've said before, connman is invoking Station.Disconnect which preven=
ts
>> iwd from reconnecting autonomously.  There's really nothing we can do ab=
out
>> that. Any issues are likely in connman.git/plugins/iwd.c
> =

> Does Station.Disconnect and AutoConnect=3Dfalse disable the iwd's scan
> engine? The pluning relies on getting SSIDs updates.
> =


So iwd is built to scan the least amount possible, since scanning interrupt=
s =

your link (radio has to physically switch off the channel, so your packets =
are =

lost in the meantime).  We scan only when in 'Autoconnect' state and when s=
ignal =

strength gets so low we need to try and roam.  If the network supports neig=
hbor =

reports or other advanced BSS mangement features, we use those to minimize =
the =

set of channels we scan.

In Autoconnect mode (and only in Autoconnect mode when we're not connected =

anywhere else) iwd scans periodically.  If a network is marked =

AutoConnect=3Dfalse, then that network is not considered as a candidate in =
this stage.

Station.Disconnect tells iwd to disconnect from whatever it is connected to=
 and =

not enter into its Autoconnect mode.  This is essentially used to tell iwd =
that =

some external application wants to control how scanning  & autoconnect logi=
c is =

performed.

In general, I would encourage using iwd's autoconnect logic since it can =

optimize the scan parameters and reconnect quickly.  This is why you see iw=
d =

re-connect to networks about 10x faster than NM+wpa_s.

Regards,
-Denis
--===============6290927424670908998==--

