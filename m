Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD51F2BA7
	for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997738; cv=none; b=exvZdcKqBZGalvdXScyBjCNo3DlV1FDcijYMQd1Gkc0WH3/gBhWA6+t9IPxEPJVOrtBTFVLiYtelUOMBLTzvT3U0TnMwFT9NQzdQwDlXgkMJFwIybfiJl+oAx3huxSJDNiZW6frKuSKRku1Rg7Wk6J9xA4iu+JLY7rFfrrEcJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997738; c=relaxed/simple;
	bh=LNzK0ysxHvSKz+pc9kchBVw2otcLEzkBMOPI1ARskFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak6/ptAXwChazKNP9ms6KXH57hHYU/9Fx6iu2V5uQRHmb/Kea6fwNsNdq+bDPAGBWd7ydAtvBMt4wQihT6f32BDLBt8fJkSvc89/vkavJmQAc8wojsFN1KKnnEyA6U3c4GaMRi2bisG7Lhdx1N0Jwh/Eg2KwQX7BY3Yk3jHPgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com; spf=fail smtp.mailfrom=dgtlrift.com; dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b=pWkgnIJT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b="pWkgnIJT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so1096725e9.1
        for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dgtlrift-com.20230601.gappssmtp.com; s=20230601; t=1739997733; x=1740602533; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slYGDCki8AjCNnwrKSocQkDf+3FVdvomZBhGE7Fp89Y=;
        b=pWkgnIJTV0G06nU9U/4JCOuYRFm12DzG9/l48iUxLdmMpxvu5B6wtbQw3jbm2hd+pI
         teHxqKIuEXFVH5E9Z5YMnm1UMb22lFKSYj49yQsHf9AmMxc19zPecDDez5i9SMAaJsAH
         vo9ZPnFgZlxBFh9RnPUkRIU6eikXqQox4ElyAH8HfM+B4ikapie4JhA9CD7mjvzdbqPp
         upYbdwu4aH7CbBEjda3/sAnOMtdQR5T1yu/F3qIMTcbEsnwCwezgXp/otDFmG+WzSGB9
         MKXCvAdMexLmT/CNaRQFpaGauSzs5JeNJhRpUtbNlVw1sAS8WGXnFw07PFWwm6jt6wvR
         Gyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997733; x=1740602533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slYGDCki8AjCNnwrKSocQkDf+3FVdvomZBhGE7Fp89Y=;
        b=XXz72ohPEiZhDjULRSzu5nLvyUG/WN5sx8sJ0C+cxQhcUaDMILmDjNapJex5KNEMna
         0sUucpmNBThXJw4orMFJS1es7Szpvgc7dIZKi9DnS57ZJTe1x+BisNWa2UzFPYnuaJqD
         vu8iSdj5WpqBQHChE7hoI9qOA8kuFLnPOmFBh8KsEAW7BfJ0YniWLZIhaqB3xpz4IXP0
         /eDCO4yXA9KMshi76brrU1JiH+sHWS7lLpFYSK2tCh8o4y0A2TX9tE+gGZD1/OUPyksC
         kfKlp3DpgrdCBrT/W5I/UOo607W+OQm0BeWzFaj2KzBJ7xuFyPJjypIWaNekxEUOQ/E2
         lbjg==
X-Gm-Message-State: AOJu0YwGOb2ud5IP48DPwkuEDWFq7WczpMSRHmWyGoPYUNxeDFU0CWDN
	vp6+KLK5sAwAUbZpqA5z2dtqSwAi4wRIaym2UJH1nca3yF7K5rILndQRh3SSpTTpRocTsirDJet
	poot5mNYorc6Lrj3M7DEWAuQnWTxy0wgj72yPc/LZrP3C5skCAz0E
X-Gm-Gg: ASbGncvVfgcVxNLbWerj2aVacjqRdJ9KCGSUBYF0p3ZWgehXxELVsGmBcPCp2i7+Daj
	3SNUHvpoforcuk2ed+mi7giVEiEatKZ4GVDjEMjhGDB/j8jUFsN3UqnV/ptOdvh+EYSFO4eMQ
X-Google-Smtp-Source: AGHT+IGvKsMmJOTK0XmhiSdb5VLmw2kdDpCQRNiVMd7ytXx9Q/rWFqae18MkyIApPUNnKqYt9ia7MZ5J9a8GzcZ626g=
X-Received: by 2002:a05:600c:354c:b0:439:9595:c8e8 with SMTP id
 5b1f17b1804b1-4399595cb04mr88144705e9.0.1739997732748; Wed, 19 Feb 2025
 12:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
 <97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com>
In-Reply-To: <97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com>
From: James Hanley <jhanley@dgtlrift.com>
Date: Wed, 19 Feb 2025 15:42:01 -0500
X-Gm-Features: AWEUYZkbY-es-ye3fsQ6gYUNXojcMx_F5sa_X55XifLDBJfOh_Z5EsbNq-LBPuc
Message-ID: <CAF++6AMYxXJZg_im3z_4PDgUj0tr7t4Ag0KFetoTu-SKuYcYVQ@mail.gmail.com>
Subject: Re: Exposing bssid information
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks - this is really helpful for direction. I was going to
initially brute force load all the attributes into a new interface,
but it seems the preferred course from your suggestion is to gather
the ESSID information and query each node individually for the BSSID
information and populate that method with the associated details?

One point that I'm stumbling on in testing the pristine codebase is
accessing the ExtendedServiceSet property:
test-wifi/test# dbus-send --system --type=3Dmethod_call --print-reply
--dest=3Dnet.connman.iwd /net/connman/iwd/0/2/53-elided-53_psk
net.connman.iwd.Network.ExtendedServiceSet
Error org.freedesktop.DBus.Error.NotFound: No matching method found

When I query for the available interfaces and methods, I am able to see:
test-wifi/test# dbus-send --system --type=3Dmethod_call --print-reply
--dest=3Dnet.connman.iwd /net/connman/iwd/0/2/53-elided-53_psk
org.freedesktop.DBus.Introspectable.Introspect
method return time=3D1739996534.609643 sender=3D:1.1090 ->
destination=3D:1.1474 serial=3D2631 reply_serial=3D2
   string "<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object
Introspection 1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
<node>
        <interface name=3D"org.freedesktop.DBus.Introspectable">
                <method name=3D"Introspect">
                        <arg name=3D"xml" type=3D"s" direction=3D"out"/>
                </method>
        </interface>
        <interface name=3D"net.connman.iwd.Network">
                <method name=3D"Connect">
                </method>
                <property name=3D"Name" type=3D"s" access=3D"read"/>
                <property name=3D"Connected" type=3D"b" access=3D"read"/>
                <property name=3D"Device" type=3D"o" access=3D"read"/>
                <property name=3D"Type" type=3D"s" access=3D"read"/>
                <property name=3D"KnownNetwork" type=3D"o" access=3D"read"/=
>
                <property name=3D"ExtendedServiceSet" type=3D"ao" access=3D=
"read"/>
        </interface>
        <interface name=3D"org.freedesktop.DBus.Properties">
                <method name=3D"Get">
                        <arg name=3D"interface_name" type=3D"s" direction=
=3D"in"/>
                        <arg name=3D"property_name" type=3D"s" direction=3D=
"in"/>
                        <arg name=3D"value" type=3D"v" direction=3D"out"/>
                </method>
                <method name=3D"Set">
                        <arg name=3D"interface_name" type=3D"s" direction=
=3D"in"/>
                        <arg name=3D"property_name" type=3D"s" direction=3D=
"in"/>
                        <arg name=3D"value" type=3D"v" direction=3D"in"/>
                </method>
                <method name=3D"GetAll">
                        <arg name=3D"interface_name" type=3D"s" direction=
=3D"in"/>
                        <arg name=3D"props" type=3D"a{sv}" direction=3D"out=
"/>
                </method>
                <signal name=3D"PropertiesChanged">
                        <arg name=3D"interface_name" type=3D"s"/>
                        <arg name=3D"changed_properties" type=3D"a{sv}"/>
                        <arg name=3D"invalidated_properties" type=3D"as"/>
                </signal>
        </interface>
        <node name=3D"d8-elided-95"/>
        <node name=3D"d8-elided-55"/>
        <node name=3D"d8-elided-15"/>
        <node name=3D"d8-elided-95"/>
        <node name=3D"d8-elided-55"/>
        <node name=3D"d8-elided-95"/>
</node>
"

Is there something I'm missing in attempting to access this detail
from dbus-send?  Ultimately this is only for testing, but I do plan on
using the DBusConnection c-api and getting it right with dbus-send
will help me in defining the code flow.

-Jim

On Sat, Feb 15, 2025 at 3:29=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Jim,
>
> On 2/15/25 12:10 PM, James Hanley wrote:
> > Hi,
> > I=E2=80=99m looking to access (and/or expose) via dbus scanned informat=
ion on
> > bssid. Specifically, information as follows:
> >
> > {
> >    "wifiAccessPoints": [
> >   {
> >    "macAddress": "f0:d5:bf:fd:12:ae",
> >    "signalStrength": -43,
> >    "signalToNoiseRatio": 0,
> >    "channel": 11,
> >    "age": 0
> > },
> > {
> >    "macAddress": "3c:37:86:5d:75:d4",
> >    "signalStrength": -35,
> >    "signalToNoiseRatio": 0
> > },
> > {
> >    "macAddress": "30:86:2d:c4:29:d0",
> >    "signalStrength": -35,
> >    "signalToNoiseRatio": 0
> > }
> >   ]
> > }
> >
> > This would be for geolocation services such as skyhook or google
> > https://developers.google.com/maps/documentation/geolocation/requests-g=
eolocation
> > to allow a device to estimate its location. It seems that what is
> > exposed is ESSID information with the strongest AP, or does is this
> > information already exposed in iwd and which module/interface should
> > be used? If not exposed, which model would be the most appropriate to
> > add this to - scan, station, or another - and what interface for dbus
> > should the method be exposed through?
>
> Take a look at the ExtendedServiceSet property [1] on the network
> objects. This contains a list of BasicServiceSet object [2] paths. At
> the moment the BasicServiceSet objects only contain the BSSID as this
> was all I really needed for the affinity functionality, but I'm not
> opposed to additional info being added such as signal strength/channel
> etc. If you need any pointers for this let me know, but it should be
> relatively straight forward to add extra properties in the interface
> setup [3].
>
> iwctl also supports showing the BSS object paths/properties via:
>
> "station wlan0 get-bsses"
>
> [1]
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/network-=
api.txt#n54
> [2]
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/basic-se=
rvice-set.txt
> [3]
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.=
c#n2196
> >
> > -Jim
> >
