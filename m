Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE55136330
	for <iwd@lists.linux.dev>; Sat, 12 Oct 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728730773; cv=none; b=ePLXO+Sw63YFMMdf9PUP/ICXqAgXbq5eP7EpgjCgcDoLGmF2uTYRm8tjV6b2RrCUhAnPLh9zZT9PmSRdzrKiUK+ho1VSFSlTw8aBeRtdNVCsGS7Xjr5hmdIUGdfHGgKHOXJiLeZldCydZT0R4vo4hlcEOmN5VA76AQCLKEC5aBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728730773; c=relaxed/simple;
	bh=ghJHfVK20pc4571XgSumMFmmeybz+5P4NnJi51iQhoA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r3Z62Q/UxWkfx8izLk8E4I7MHIij90zMqxiM8g1Mb+2RQqYLxOETyOD7QiyfbwzMJaOUBUIhEkx6TYdYyoZwBkvoroaxM22Q5EqY4jtXYRJLh1ECKWDDPHVcMNNHF8s4RNocdTXYQN/Y6pYLktZWm0jM9zMulDOZTiHl7jfXrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=bw3gAtbd; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="bw3gAtbd"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4XQgVH191pz9tKw;
	Sat, 12 Oct 2024 12:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1728730759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/C/sAE4Le1MCyBdsaNhsGh+URkkXnPvv78jXGeLy0U=;
	b=bw3gAtbdlVODV3pJrw9wZKTLq4No6spOvkX3pprJWDsVabHdGFJdwFIa9DB7441oOZQSjH
	8JGozY/quF9CyIZmUtRDmeqq2TPItsfQoM/KMVbKj6Vn2bfzQFGI06VOZfhxj97+1GUUcP
	/FjJYaXEqVs7LS0UhI4XxVomMgpCI3X9YNeo2pL51ACVPZkN+y6e043H3XFBsbIxMgJxeW
	0Pip6h9LbxuSz6mf8nKj78YLCvUq88NxsGSHzpEDKSZSc/lmhhl0S20QFD2a/ycrMEnfRq
	Z+QSpLHPSqT2QNHa5W+BrCbTtvSvH1HQnoskYUJnZfdhKucKkKPwyQtjT1OAiA==
Message-ID: <81a4083c-6e84-45f0-925b-f483bed9e3a7@tavla.de>
Date: Sat, 12 Oct 2024 12:59:17 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
From: Martin Petzold <martin.petzold@tavla.de>
To: James Prestwood <prestwoj@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
 <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
 <1fcf76fd-85ab-4a31-8aaf-9d6922ab3a97@tavla.de>
 <b6f570d9-c14d-4e71-87a7-3e7d2c2fd6ca@gmail.com>
 <5ab61b3b-1b31-42e2-8b3b-9c96acfd3c1a@tavla.de>
 <1a4087a8-47cf-4876-8449-a7ce2cd08a90@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <1a4087a8-47cf-4876-8449-a7ce2cd08a90@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XQgVH191pz9tKw

Hi all,

Am 11.10.24 um 12:46 schrieb Martin Petzold:
> Hi all,
>
> Am 11.10.24 um 10:35 schrieb Martin Petzold:
>> Hi James,
>>
>> Am 10.10.24 um 15:55 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 10/10/24 6:47 AM, Martin Petzold wrote:
>>>> Hi James,
>>>>
>>>> Am 10.10.24 um 15:36 schrieb James Prestwood:
>>>>>
>>>>> On 10/10/24 6:20 AM, Martin Petzold wrote:
>>>>>> Hi Denis,
>>>>>>
>>>>>> Am 09.10.24 um 18:07 schrieb Denis Kenzior:
>>>>>>> [...]
>>>>>>>
>>>>>>>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>>>>>>>> package?) -> how to do best and will this work with libc6 
>>>>>>>> version 2.36? Missing libreadline8t64?
>>>>>>>
>>>>>>> I mean this is your only real solution.  There is no 'long term 
>>>>>>> support' model for iwd.  You either run the latest or you're on 
>>>>>>> your own.  It is highly unlikely that any of the developers will 
>>>>>>> look at logs (or attempt to fix) anything but the latest version.
>>>>>>>
>>>>>>>
>>>>>> Why does the following build fail. I did not install 
>>>>>> 'python-docutils' package because is is not available for Debian 
>>>>>> bookworm (only a source package). How should I proceed? Maybe the 
>>>>>> documentation should be fixed then for Debian bookworm.
>>>>> You need to use an updated version of ELL. IWD and ELL get 
>>>>> released in tandem in case of any API/behavior changes. 
>>>>
>>>> I used for both git HEAD repository (how can I get both in line?):
>>>
>>> Sorry, I just glanced over the error and assumed incorrectly. It 
>>> looks like -Werror isn't enabled (?) so that warning should be fine. 
>>> But the issue, as you said, is docs related. You could try to 
>>> configure with --disable-manual-pages
>>
>> That helps, thanks. Maybe should be added to the documentation.
>>
>> Now using a cross-build make install does not respect my 
>> "--prefix=/scratch/root/usr" for installation of files to "share". It 
>> should install to "/scratch/root/usr/share/dbus-1/system-services". 
>> Already searching for the correct parameters. But maybe you know why 
>> and maybe also should be added to the documentation?
>>
>> 2024/10/10 18:47:08 iwd 'development' 'amd64' | + ./configure 
>> --prefix=/scratch/root/usr --localstatedir=/var --sysconfdir=/etc 
>> --disable-manual-pages
>> 2024/10/10 18:47:10 iwd 'development' 'amd64' | checking for a 
>> BSD-compatible install... /usr/bin/install -c
>> [...]
>> 2024/10/10 18:53:00 iwd 'development' 'amd64' |   CC 
>> tools/iwd-decrypt-profile.o
>> 2024/10/10 18:53:01 iwd 'development' 'amd64' |   CCLD 
>> tools/iwd-decrypt-profile
>> 2024/10/10 18:53:03 iwd 'development' 'amd64' | + make install
>> 2024/10/10 18:53:03 iwd 'development' 'amd64' | make 
>> --no-print-directory install-am
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
>> '/scratch/root/usr/bin'
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' |   /bin/bash 
>> ./libtool   --mode=install /usr/bin/install -c client/iwctl 
>> monitor/iwmon '/scratch/root/usr/bin'
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
>> /usr/bin/install -c client/iwctl /scratch/root/usr/bin/iwctl
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
>> /usr/bin/install -c monitor/iwmon /scratch/root/usr/bin/iwmon
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
>> '/scratch/root/usr/libexec'
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' |   /bin/bash 
>> ./libtool   --mode=install /usr/bin/install -c src/iwd 
>> '/scratch/root/usr/libexec'
>> 2024/10/10 18:53:04 iwd 'development' 'amd64' | libtool: install: 
>> /usr/bin/install -c src/iwd /scratch/root/usr/libexec/iwd
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' |  /usr/bin/mkdir -p 
>> '/usr/share/dbus-1/system-services'
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' | /usr/bin/install -c 
>> -m 644 src/net.connman.iwd.service '/usr/share/dbus-1/system-services'
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' | /usr/bin/install: 
>> cannot create regular file 
>> '/usr/share/dbus-1/system-services/net.connman.iwd.service': 
>> Permission denied
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' | make[2]: *** 
>> [Makefile:2798: install-dbus_busDATA] Error 1
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' | make[1]: *** 
>> [Makefile:3466: install-am] Error 2
>> 2024/10/10 18:53:05 iwd 'development' 'amd64' | make: *** 
>> [Makefile:3459: install] Error 2
>>
>>
> All the following is elaborated for Debian (12) based systems. The 
> build works using a specific location with:
>
> ./configure --prefix=${ROOTDIR}/usr --localstatedir=${ROOTDIR}/var 
> --sysconfdir=${ROOTDIR}/etc --with-dbus-datadir=${ROOTDIR}/usr/share 
> --with-dbus-busdir=${ROOTDIR}/usr/share/dbus-1/system-services 
> --with-systemd-unitdir=${ROOTDIR}/lib/systemd/system 
> --with-systemd-networkdir=${ROOTDIR}/lib/systemd/network 
> --with-systemd-modloaddir=${ROOTDIR}/usr/lib/modules-load.d 
> --disable-manual-pages
>
> make install
>
> Another work-around (without respecting correct path detection during 
> configure):
>
> ./configure --prefix=${ROOTDIR}/usr --localstatedir=${ROOTDIR}/var 
> --sysconfdir=${ROOTDIR}/etc --disable-manual-pages
>
> DESTDIR=${ROOTDIR} PREFIX=/usr make install
>
> If I understand right, in the configure script the $(prefix) is not 
> used for d-bus and the other "--with-*" parameters. Maybe also not for 
> "localstatedir" and "sysconfdir". This can have several side-effects 
> (files build against wrong location / installed to wrong location). 
> IMHO the script should be cleaned-up to respect "--prefix" in all 
> cases as recommended in: 
> https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
>
> However, this only works for Linux systems with 
> "/usr/lib", "/usr/share" etc. I am not sure about this, but isn't this 
> the default?
>
> IMHO the script should be fixed to build and install with:
>
> ./configure --prefix=/usr --disable-manual-pages
>
> make install
>
> AND (for cross-build):
>
> ./configure --prefix=${ROOTDIR}/usr --disable-manual-pages
>
> make install

Additional fix of the execution path is required for cross-build:

sudo sed -i "s^ExecStart=.*^ExecStart=/usr/libexec/iwd^" 
${ROOTDIR}/lib/systemd/system/iwd.service

