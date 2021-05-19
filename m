Content-Type: multipart/mixed; boundary="===============3084564133713274329=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Wed, 19 May 2021 16:20:20 -0500
Message-ID: <9edf45db-6cb5-1a9c-68da-5f08ff9332e9@gmail.com>
In-Reply-To: <CAG17S_McO=OtGotbDn7ccDSbzu7vA_T4-ge593owud37bLBr+Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3084564133713274329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 5/19/21 2:36 PM, KeithG wrote:
> Group,
> =

> I am not sure if this is the right terminology but this is what I am
> trying to do:
> Power up a headless device. If it does not get an ethernet or wifi
> connection, it launches AP mode of some sort and allows a device to
> connect then configure the wifi connection by selecting an AP and
> typing in a password.
> =

> This works with hostapd/dsnmasq, currently. I want to switch over to
> connman and/or iwd to do this, but have not been successful in doing
> this.

So do you know how this works, exactly?

> =

> If I set up connman by:
> "# connmanctl tether wifi on SSID password" I can connect and 'see' my
> new SSID, but I cannot scan for any APs to set up. I do not know how
> to set the SSID IP address, if this has been enabled in connman.

Daniel or Marcel can correct me if I'm wrong, but I don't think this is a =

usecase connman supports.  Tethering is just that, sharing your =

ethernet/wwan/whatever connection over wifi.

> =

> I have tried with iwctl as well:
> set up /etc/iwd/main.conf
> [General]
> EnableNetworkConfiguration=3Dtrue
> APRanges=3D192.168.1.0/24
> =

> # iwctl device wlan0 set-property Mode ap
> # iwctl ap wlan0 start SSID password
> =

> With this I can connect, but once again, I cannot scan for any
> available SSIDs to connect to. It is not important that I be able to
> connect, but I do need to see the SSIDs so the user can set it up then
> reboot (or restart connman/iwd) to connect to the new 'known' SSID.

So I think there are two ways of doing this:

1. Being able to scan while in AP mode.  This is something that has been br=
ought =

up before as desirable, etc.  But no one has made any contributions just ye=
t. =

All this does is lets you see the surrounding SSIDs...

2. Use multiple interfaces if your hw supports them.  So 1 interface in AP =
mode, =

the other in station mode.  Then you could connect to the headless device o=
n the =

ap interface and run iwd on the station interface as usual to set up the ne=
twork.

In theory 2 can be done today, either by iwd or combo iwd/hostapd with some =

manual magic.

Regards,
-Denis
--===============3084564133713274329==--

