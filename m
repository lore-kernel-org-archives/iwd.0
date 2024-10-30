Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB9214406
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319227; cv=none; b=bYa1jlblrnJZ4aikBJHBkj0k/5+ktUpUVTO4/4G5dnhUNR9651Hm6wPNaFrPkdItpjINY4OOVPBTWFVFYnfIkZrRVm9A1LIjge3LeKW1pJnqocS2wTBnTQrA09VxAEWli7bxtXbqhUjK45ihxTymqIk5BKnPR7KmdR3Iw+bMyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319227; c=relaxed/simple;
	bh=GEgKwtV1iRU8MUSczOTAxxTujm6E5j07uZsYdQRePK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mW77zvd4qJPSUzhtgkT+OuBCFy9Pj3lU69BGM+CgKURWnJ9Wn8EPN+2EiUx0LR0gFFpe9KA1PWs9j95AeAEl4Pg4Iw+YAkG4snKQVTYuHP0jotXczQHSkltSv68FLtrTBTkREnlRYpzOyDzkkFOJr5LmM91drXcs3snP9jAN6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=eX8BjDMi; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="eX8BjDMi"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4XdyxW2JsNz9vrg;
	Wed, 30 Oct 2024 21:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730319215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJxee9nQwrz2KEvIYaupxJabOIeQy40nbWP14sMmQF4=;
	b=eX8BjDMiTN+vnr0fQ83NElxHFJDQWlYjj7fLni0GM/k0Cna+XlI8nWzF25RIm/WkMrXfZu
	iZ1P0ywXU8KE+ePDZtm9qVg4wbD4nF65gWKkiNFRC9JXZh5y2DhkzUNSDs0PgnkP7orv1N
	x0KjJSgxkfBFCnZSnqqJ3h8e1pYpZsIn6zHRuUxVN1+s5ehzZtUCu8iq2dY2QBEsDcZ6bX
	PmjjS2zg9DfvV5bOq661T8cmWrcVrE5GxVDhhNdkk6qSOdYmY5RfGHplwzQQXpVofkARRu
	kJ+mPRYhZ0P0r6NWtnRZxH0b7dcd4NsDfX0hrf2kXicSXw8uamU5dfjyn3lP5g==
Message-ID: <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
Date: Wed, 30 Oct 2024 21:13:34 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: James Prestwood <prestwoj@gmail.com>
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 30.10.24 um 21:00 schrieb James Prestwood:
> Hi Martin,
>
> On 10/30/24 12:54 PM, Martin Petzold wrote:
>> Hi,
>>
>> to disable "power save" with NetworkManager I used:
>>
>> -----
>>
>> [connection]
>> wifi.powersave = 2
>>
>> -----
>>
>> However, using IWD (with iwlwifi or brcmfmac) I don't know how to get 
>> this set:
>>
>> A. "options iwlwifi power_save=0" in 
>> "/etc/modprobe.d/wifi-power-save.conf" does not work
>>
>> B. "[DriverQuirks]" with parameter "PowerSaveDisable=iwlwifi" does 
>> not work
>>
>> C. "[DriverQuirks]" with parameter "PowerSaveDisable=*" does not work
>
> And you have this set in main.conf? This works for me, on iwlwifi. 
> When you start IWD you should see:
>
> Driver Flags: PowerSaveDisable
>
> And for me iw wlan0 get power_save shows "off"
>
> My setting in main.conf is:
>
> [DriverQuirks]
> PowerSaveDisable=iwlwifi
tavla@tavla:~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EnableIPv6=false

[DriverQuirks]
PowerSaveDisable=iwlwifi
tavla@tavla:~$
tavla@tavla:~$
tavla@tavla:~$ sudo iw wlan0 get power_save
Power save: on
tavla@tavla:~$
tavla@tavla:~$ sudo journalctl --no-pager | grep iwlwifi
Okt 29 19:19:14 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 29 19:19:14 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 29 19:19:14 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 29 19:19:14 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 29 19:19:15 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 29 21:10:22 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 29 21:10:22 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 29 21:10:22 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 29 21:10:22 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 29 21:10:23 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 06:01:50 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 06:01:50 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 06:01:50 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 06:01:50 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 06:01:50 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 20:33:25 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 20:33:25 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 20:33:25 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 20:33:26 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 20:33:26 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 20:36:35 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 20:36:35 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 20:36:35 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 20:36:35 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 20:36:36 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 20:39:25 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 20:39:25 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 20:39:25 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 20:39:26 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 20:39:26 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 20:42:56 tavla systemd-modules-load[233]: Failed to find module 
'options iwlwifi power_save=0'
Okt 30 20:42:57 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 20:42:57 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 20:42:57 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 20:42:57 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 20:42:57 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
Okt 30 20:54:02 tavla sudo[1504]:    tavla : TTY=pts/0 ; PWD=/home/tavla 
; USER=root ; COMMAND=/usr/sbin/modinfo iwlwifi
Okt 30 21:06:44 tavla systemd-modules-load[235]: Failed to find module 
'options iwlwifi power_save=0'
Okt 30 21:06:45 tavla kernel: iwlwifi 0000:01:00.0: enabling device 
(0000 -> 0002)
Okt 30 21:06:45 tavla kernel: iwlwifi 0000:01:00.0: firmware: 
direct-loading firmware iwlwifi-8000C-36.ucode
Okt 30 21:06:45 tavla kernel: iwlwifi 0000:01:00.0: loaded firmware 
version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
Okt 30 21:06:46 tavla kernel: iwlwifi 0000:01:00.0: Detected Intel(R) 
Dual Band Wireless AC 8260, REV=0x201
Okt 30 21:06:46 tavla kernel: iwlwifi 0000:01:00.0: base HW address: 
60:f6:77:df:20:c3, OTP minor version: 0x0
tavla@tavla:~$
tavla@tavla:~$ sudo modinfo iwlwifi
filename: 
/lib/modules/6.1.0-18-amd64/kernel/drivers/net/wireless/intel/iwlwifi/iwlwifi.ko
license:        GPL
description:    Intel(R) Wireless WiFi driver for Linux
firmware:       iwlwifi-100-5.ucode
firmware:       iwlwifi-1000-5.ucode
firmware:       iwlwifi-135-6.ucode
firmware:       iwlwifi-105-6.ucode
firmware:       iwlwifi-2030-6.ucode
firmware:       iwlwifi-2000-6.ucode
firmware:       iwlwifi-5150-2.ucode
firmware:       iwlwifi-5000-5.ucode
firmware:       iwlwifi-6000g2b-6.ucode
firmware:       iwlwifi-6000g2a-6.ucode
firmware:       iwlwifi-6050-5.ucode
firmware:       iwlwifi-6000-4.ucode
firmware:       iwlwifi-7265D-29.ucode
firmware:       iwlwifi-7265-17.ucode
firmware:       iwlwifi-3168-29.ucode
firmware:       iwlwifi-3160-17.ucode
firmware:       iwlwifi-7260-17.ucode
firmware:       iwlwifi-8265-36.ucode
firmware:       iwlwifi-8000C-36.ucode
firmware:       iwlwifi-9260-th-b0-jf-b0-46.ucode
firmware:       iwlwifi-9000-pu-b0-jf-b0-46.ucode
firmware:       iwlwifi-BzBnj-b0-fm-b0-72.ucode
firmware:       iwlwifi-gl-b0-fm-b0-72.ucode
firmware:       iwlwifi-bz-a0-fm4-a0-72.ucode
firmware:       iwlwifi-BzBnj-a0-hr-b0-72.ucode
firmware:       iwlwifi-BzBnj-a0-gf4-a0-72.ucode
firmware:       iwlwifi-BzBnj-a0-gf-a0-72.ucode
firmware:       iwlwifi-BzBnj-a0-fm4-a0-72.ucode
firmware:       iwlwifi-BzBnj-a0-fm-a0-72.ucode
firmware:       iwlwifi-gl-a0-fm-a0-72.ucode
firmware:       iwlwifi-bz-a0-fm-a0-72.ucode
firmware:       iwlwifi-bz-a0-mr-a0-72.ucode
firmware:       iwlwifi-bz-a0-gf4-a0-72.ucode
firmware:       iwlwifi-bz-a0-gf-a0-72.ucode
firmware:       iwlwifi-bz-a0-hr-b0-72.ucode
firmware:       iwlwifi-SoSnj-a0-mr-a0-72.ucode
firmware:       iwlwifi-ma-a0-fm-a0-72.ucode
firmware:       iwlwifi-ma-a0-mr-a0-72.ucode
firmware:       iwlwifi-ma-a0-gf4-a0-72.ucode
firmware:       iwlwifi-ma-a0-gf-a0-72.ucode
firmware:       iwlwifi-ma-a0-hr-b0-72.ucode
firmware:       iwlwifi-SoSnj-a0-jf-b0-72.ucode
firmware:       iwlwifi-SoSnj-a0-hr-b0-72.ucode
firmware:       iwlwifi-SoSnj-a0-gf-a0-72.ucode
firmware:       iwlwifi-SoSnj-a0-gf4-a0-72.ucode
firmware:       iwlwifi-ty-a0-gf-a0-72.ucode
firmware:       iwlwifi-so-a0-gf-a0-72.ucode
firmware:       iwlwifi-so-a0-hr-b0-72.ucode
firmware:       iwlwifi-so-a0-jf-b0-72.ucode
firmware:       iwlwifi-cc-a0-72.ucode
firmware:       iwlwifi-QuQnj-b0-jf-b0-72.ucode
firmware:       iwlwifi-QuZ-a0-jf-b0-72.ucode
firmware:       iwlwifi-QuZ-a0-hr-b0-72.ucode
firmware:       iwlwifi-Qu-b0-jf-b0-72.ucode
firmware:       iwlwifi-Qu-c0-hr-b0-72.ucode
firmware:       iwlwifi-QuQnj-b0-hr-b0-72.ucode
firmware:       iwlwifi-Qu-b0-hr-b0-72.ucode
alias:          pci:v00008086d00007740sv*sd*bc*sc*i*
alias:          pci:v00008086d0000A840sv*sd*bc*sc*i*
alias:          pci:v00008086d0000272Bsv*sd*bc*sc*i*
alias:          pci:v00008086d00002727sv*sd*bc*sc*i*
alias:          pci:v00008086d00007E40sv*sd*bc*sc*i*
alias:          pci:v00008086d00002729sv*sd*bc*sc*i*
alias:          pci:v00008086d00007F70sv*sd*bc*sc*i*
alias:          pci:v00008086d000054F0sv*sd*bc*sc*i*
alias:          pci:v00008086d000051F1sv*sd*bc*sc*i*
alias:          pci:v00008086d000051F1sv*sd*bc*sc*i*
alias:          pci:v00008086d000051F0sv*sd*bc*sc*i*
alias:          pci:v00008086d00007AF0sv*sd*bc*sc*i*
alias:          pci:v00008086d00007A70sv*sd*bc*sc*i*
alias:          pci:v00008086d00002726sv*sd*bc*sc*i*
alias:          pci:v00008086d00002725sv*sd*bc*sc*i*
alias:          pci:v00008086d00002723sv*sd*bc*sc*i*
alias:          pci:v00008086d00002720sv*sd*bc*sc*i*
alias:          pci:v00008086d0000A0F0sv*sd*bc*sc*i*
alias:          pci:v00008086d000043F0sv*sd*bc*sc*i*
alias:          pci:v00008086d00004DF0sv*sd*bc*sc*i*
alias:          pci:v00008086d00003DF0sv*sd*bc*sc*i*
alias:          pci:v00008086d000034F0sv*sd*bc*sc*i*
alias:          pci:v00008086d000006F0sv*sd*bc*sc*i*
alias:          pci:v00008086d000002F0sv*sd*bc*sc*i*
alias:          pci:v00008086d0000A370sv*sd*bc*sc*i*
alias:          pci:v00008086d00009DF0sv*sd*bc*sc*i*
alias:          pci:v00008086d000031DCsv*sd*bc*sc*i*
alias:          pci:v00008086d000030DCsv*sd*bc*sc*i*
alias:          pci:v00008086d0000271Csv*sd*bc*sc*i*
alias:          pci:v00008086d0000271Bsv*sd*bc*sc*i*
alias:          pci:v00008086d00002526sv*sd*bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00009074bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000014bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000012bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00001012bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00003E01bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00003E02bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00001014bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000850bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000950bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000930bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000910bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00008130bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00009110bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000810bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00008010bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00008050bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00008110bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00009010bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000150bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000050bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd000010D0bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00001010bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000130bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00001130bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00001110bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000110bc*sc*i*
alias:          pci:v00008086d000024FDsv*sd00000010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00004010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000000bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000930bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000950bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000850bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000910bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000810bc*sc*i*
alias:          pci:v00008086d000024F6sv*sd00000030bc*sc*i*
alias:          pci:v00008086d000024F5sv*sd00000010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000044bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000004bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009150bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008150bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009132bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008132bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009130bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008130bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd0000D030bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd0000C030bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd00009030bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd00008030bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009110bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00009010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008110bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00008010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000B0B0bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000D0B0bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000D050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000C050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000D010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000C110bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd0000C010bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd00001030bc*sc*i*
alias:          pci:v00008086d000024F4sv*sd00000030bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001150bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000150bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000250bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000050bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001110bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001012bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000012bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd000001F0bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000110bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001132bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000132bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001130bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000130bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd000010B0bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00001010bc*sc*i*
alias:          pci:v00008086d000024F3sv*sd00000010bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009E10bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009400bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009000bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd0000520Abc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005212bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005F10bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005490bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005290bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005590bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005190bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005090bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005420bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd0000502Abc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005020bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009410bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00009310bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009510bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00009200bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00009210bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009112bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009110bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd0000900Abc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009012bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00009010bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005202bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005102bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005002bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005200bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd0000500Abc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005000bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00001010bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005400bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005510bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005410bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005412bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005012bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005C10bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005210bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005302bc*sc*i*
alias:          pci:v00008086d0000095Bsv*sd00005310bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005100bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005110bc*sc*i*
alias:          pci:v00008086d0000095Asv*sd00005010bc*sc*i*
alias:          pci:v00008086d000024FBsv*sd00000000bc*sc*i*
alias:          pci:v00008086d000024FBsv*sd00002150bc*sc*i*
alias:          pci:v00008086d000024FBsv*sd00002050bc*sc*i*
alias:          pci:v00008086d000024FBsv*sd00002110bc*sc*i*
alias:          pci:v00008086d000024FBsv*sd00002010bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00008110bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00008010bc*sc*i*
alias:          pci:v00008086d00003166sv*sd00004210bc*sc*i*
alias:          pci:v00008086d00003166sv*sd00004310bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00004110bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00004510bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00004410bc*sc*i*
alias:          pci:v00008086d00003166sv*sd00004212bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00004012bc*sc*i*
alias:          pci:v00008086d00003165sv*sd00004010bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00001170bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00001070bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008570bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008470bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00008272bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00008370bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00008270bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008062bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008060bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008172bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008170bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008072bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00008070bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00000370bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000472bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000470bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00000272bc*sc*i*
alias:          pci:v00008086d000008B4sv*sd00000270bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000062bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000060bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000172bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000170bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000072bc*sc*i*
alias:          pci:v00008086d000008B3sv*sd00000070bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C420bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C220bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C02Abc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C020bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C360bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C370bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C560bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C570bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C462bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C460bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C472bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C470bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C262bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C26Abc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C260bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C272bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000CC60bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000CC70bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000C270bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C760bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C770bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C162bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C062bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C160bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C06Abc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C060bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C170bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C072bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000C070bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004420bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004220bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000402Abc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004020bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00005770bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00005170bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00005072bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00005070bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004360bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004370bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004560bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004570bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004A6Cbc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004A6Ebc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004A70bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000486Ebc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004870bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004462bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000446Abc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004460bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004472bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004470bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004262bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd0000426Abc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004260bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004272bc*sc*i*
alias:          pci:v00008086d000008B2sv*sd00004270bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004162bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004062bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004160bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd0000406Abc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004060bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004C70bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004C60bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004170bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004072bc*sc*i*
alias:          pci:v00008086d000008B1sv*sd00004070bc*sc*i*
alias:          pci:v00008086d00000892sv*sd00000462bc*sc*i*
alias:          pci:v00008086d00000893sv*sd00000262bc*sc*i*
alias:          pci:v00008086d00000892sv*sd00000062bc*sc*i*
alias:          pci:v00008086d00000894sv*sd00000822bc*sc*i*
alias:          pci:v00008086d00000894sv*sd00000422bc*sc*i*
alias:          pci:v00008086d00000895sv*sd00000222bc*sc*i*
alias:          pci:v00008086d00000894sv*sd00000022bc*sc*i*
alias:          pci:v00008086d0000088Fsv*sd00005260bc*sc*i*
alias:          pci:v00008086d0000088Esv*sd00004860bc*sc*i*
alias:          pci:v00008086d0000088Esv*sd0000446Abc*sc*i*
alias:          pci:v00008086d0000088Esv*sd00004460bc*sc*i*
alias:          pci:v00008086d0000088Fsv*sd0000426Abc*sc*i*
alias:          pci:v00008086d0000088Fsv*sd00004260bc*sc*i*
alias:          pci:v00008086d0000088Esv*sd0000406Abc*sc*i*
alias:          pci:v00008086d0000088Esv*sd00004060bc*sc*i*
alias:          pci:v00008086d00000887sv*sd00004462bc*sc*i*
alias:          pci:v00008086d00000888sv*sd00004262bc*sc*i*
alias:          pci:v00008086d00000887sv*sd00004062bc*sc*i*
alias:          pci:v00008086d00000890sv*sd00004822bc*sc*i*
alias:          pci:v00008086d00000890sv*sd00004422bc*sc*i*
alias:          pci:v00008086d00000891sv*sd00004222bc*sc*i*
alias:          pci:v00008086d00000890sv*sd00004022bc*sc*i*
alias:          pci:v00008086d00000896sv*sd00005027bc*sc*i*
alias:          pci:v00008086d00000896sv*sd00005025bc*sc*i*
alias:          pci:v00008086d00000897sv*sd00005017bc*sc*i*
alias:          pci:v00008086d00000897sv*sd00005015bc*sc*i*
alias:          pci:v00008086d00000896sv*sd00005007bc*sc*i*
alias:          pci:v00008086d00000896sv*sd00005005bc*sc*i*
alias:          pci:v00008086d000008AEsv*sd00001027bc*sc*i*
alias:          pci:v00008086d000008AEsv*sd00001025bc*sc*i*
alias:          pci:v00008086d000008AFsv*sd00001017bc*sc*i*
alias:          pci:v00008086d000008AFsv*sd00001015bc*sc*i*
alias:          pci:v00008086d000008AEsv*sd00001007bc*sc*i*
alias:          pci:v00008086d000008AEsv*sd00001005bc*sc*i*
alias:          pci:v00008086d00000084sv*sd00001316bc*sc*i*
alias:          pci:v00008086d00000084sv*sd00001216bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001326bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001226bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001306bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001206bc*sc*i*
alias:          pci:v00008086d00000084sv*sd00001315bc*sc*i*
alias:          pci:v00008086d00000084sv*sd00001215bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001325bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001225bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001305bc*sc*i*
alias:          pci:v00008086d00000083sv*sd00001205bc*sc*i*
alias:          pci:v00008086d00000886sv*sd00001317bc*sc*i*
alias:          pci:v00008086d00000886sv*sd00001315bc*sc*i*
alias:          pci:v00008086d00000885sv*sd00001327bc*sc*i*
alias:          pci:v00008086d00000885sv*sd00001325bc*sc*i*
alias:          pci:v00008086d00000885sv*sd00001307bc*sc*i*
alias:          pci:v00008086d00000885sv*sd00001305bc*sc*i*
alias:          pci:v00008086d00000089sv*sd00001316bc*sc*i*
alias:          pci:v00008086d00000089sv*sd00001311bc*sc*i*
alias:          pci:v00008086d00000087sv*sd00001326bc*sc*i*
alias:          pci:v00008086d00000087sv*sd00001321bc*sc*i*
alias:          pci:v00008086d00000087sv*sd00001306bc*sc*i*
alias:          pci:v00008086d00000087sv*sd00001301bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005226bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005225bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005221bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005207bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005206bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005205bc*sc*i*
alias:          pci:v00008086d00000091sv*sd00005201bc*sc*i*
alias:          pci:v00008086d00000090sv*sd00005216bc*sc*i*
alias:          pci:v00008086d00000090sv*sd00005215bc*sc*i*
alias:          pci:v00008086d00000090sv*sd00005211bc*sc*i*
alias:          pci:v00008086d0000008Bsv*sd00005317bc*sc*i*
alias:          pci:v00008086d0000008Bsv*sd00005315bc*sc*i*
alias:          pci:v00008086d0000008Asv*sd00005327bc*sc*i*
alias:          pci:v00008086d0000008Asv*sd00005325bc*sc*i*
alias:          pci:v00008086d0000008Asv*sd00005307bc*sc*i*
alias:          pci:v00008086d0000008Asv*sd00005305bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001305bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001304bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00004820bc*sc*i*
alias:          pci:v00008086d00000085sv*sd0000C228bc*sc*i*
alias:          pci:v00008086d00000085sv*sd0000C220bc*sc*i*
alias:          pci:v00008086d00000082sv*sd0000C020bc*sc*i*
alias:          pci:v00008086d00000085sv*sd00001316bc*sc*i*
alias:          pci:v00008086d00000085sv*sd00001318bc*sc*i*
alias:          pci:v00008086d00000085sv*sd00001311bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001328bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001326bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001321bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001308bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001307bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001306bc*sc*i*
alias:          pci:v00008086d00000082sv*sd00001301bc*sc*i*
alias:          pci:v00008086d00004239sv*sd00001316bc*sc*i*
alias:          pci:v00008086d00004239sv*sd00001311bc*sc*i*
alias:          pci:v00008086d00004238sv*sd00001118bc*sc*i*
alias:          pci:v00008086d00004238sv*sd00001111bc*sc*i*
alias:          pci:v00008086d0000422Csv*sd00001326bc*sc*i*
alias:          pci:v00008086d0000422Csv*sd00001321bc*sc*i*
alias:          pci:v00008086d0000422Csv*sd00001307bc*sc*i*
alias:          pci:v00008086d0000422Csv*sd00001306bc*sc*i*
alias:          pci:v00008086d0000422Csv*sd00001301bc*sc*i*
alias:          pci:v00008086d0000422Bsv*sd00001128bc*sc*i*
alias:          pci:v00008086d0000422Bsv*sd00001121bc*sc*i*
alias:          pci:v00008086d0000422Bsv*sd00001108bc*sc*i*
alias:          pci:v00008086d0000422Bsv*sd00001101bc*sc*i*
alias:          pci:v00008086d0000423Dsv*sd00001316bc*sc*i*
alias:          pci:v00008086d0000423Dsv*sd00001216bc*sc*i*
alias:          pci:v00008086d0000423Dsv*sd00001311bc*sc*i*
alias:          pci:v00008086d0000423Dsv*sd00001211bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001326bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001321bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001221bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001306bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001206bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001301bc*sc*i*
alias:          pci:v00008086d0000423Csv*sd00001201bc*sc*i*
alias:          pci:v00008086d0000423Bsv*sd00001011bc*sc*i*
alias:          pci:v00008086d0000423Asv*sd00001021bc*sc*i*
alias:          pci:v00008086d0000423Asv*sd00001001bc*sc*i*
alias:          pci:v00008086d00004236sv*sd00001114bc*sc*i*
alias:          pci:v00008086d00004236sv*sd00001014bc*sc*i*
alias:          pci:v00008086d00004236sv*sd00001111bc*sc*i*
alias:          pci:v00008086d00004236sv*sd00001011bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001104bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001004bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001101bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001001bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001124bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001024bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001121bc*sc*i*
alias:          pci:v00008086d00004235sv*sd00001021bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001316bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001216bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001315bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001215bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001314bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001214bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001311bc*sc*i*
alias:          pci:v00008086d00004237sv*sd00001211bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001326bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001226bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001325bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001225bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001324bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001224bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001321bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001221bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001306bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001206bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001305bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001205bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001304bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001204bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001301bc*sc*i*
alias:          pci:v00008086d00004232sv*sd00001201bc*sc*i*
depends:        cfg80211
retpoline:      Y
intree:         Y
name:           iwlwifi
vermagic:       6.1.0-18-amd64 SMP preempt mod_unload modversions
sig_id:         PKCS#7
signer:         Debian Secure Boot CA
sig_key: 32:A0:28:7F:84:1A:03:6F:A3:93:C1:E0:65:C4:3A:E6:B2:42:26:43
sig_hashalgo:   sha256
signature: 08:EB:45:06:82:69:46:26:49:A6:45:BF:73:32:0F:FB:A1:D0:D8:35:
         74:E4:27:6F:B8:B1:32:A0:84:27:4B:EF:D3:16:0A:58:1C:3A:B1:FF:
         10:15:23:60:C4:4D:A3:84:5E:DF:81:DF:67:C0:8B:57:DB:3F:25:73:
         1D:D1:56:44:D0:77:DD:A1:9C:DE:A3:FD:9A:9D:91:BD:2B:F2:FC:DB:
         D8:F5:5A:0F:1C:D5:21:54:CC:C7:20:69:B2:AE:9F:8D:3F:3D:24:FF:
         FB:8C:DD:04:9F:AA:8E:A3:66:D7:E4:1F:E1:85:38:18:F1:A4:C8:2E:
         41:B8:82:14:0B:02:04:06:54:5F:6A:22:3F:66:F6:0F:57:C0:98:A4:
         66:5B:3A:F0:78:BD:9B:1D:39:2F:FF:91:58:25:9F:B0:8E:83:6C:9D:
         A5:CE:34:6A:9A:03:1D:84:AB:AB:A3:7B:2B:34:28:31:9D:B9:D6:70:
         A7:10:CE:E5:C9:36:B8:16:48:09:22:94:B8:1E:58:48:8E:85:E2:F5:
         8C:7B:30:A2:11:62:CC:33:6C:3D:A1:38:90:09:40:63:DF:8B:61:E8:
         4C:31:22:FA:8D:24:DA:06:2E:9F:AD:F1:D4:4F:1A:6B:FD:EC:6F:10:
         22:3F:F0:31:FD:CE:70:9E:6B:7B:AC:FE:7E:EF:7F:A7
parm:           swcrypto:using crypto in software (default 0 [hardware]) 
(int)
parm:           11n_disable:disable 11n functionality, bitmap: 1: full, 
2: disable agg TX, 4: disable agg RX, 8 enable agg TX (uint)
parm:           amsdu_size:amsdu size 0: 12K for multi Rx queue devices, 
2K for AX210 devices, 4K for other devices 1:4K 2:8K 3:12K (16K buffers) 
4: 2K (default 0) (int)
parm:           fw_restart:restart firmware in case of error (default 
true) (bool)
parm:           nvm_file:NVM file name (charp)
parm:           uapsd_disable:disable U-APSD functionality bitmap 1: BSS 
2: P2P Client (default: 3) (uint)
parm:           enable_ini:0:disable, 1-15:FW_DBG_PRESET Values, 
16:enabled without preset value defined,Debug INI TLV FW debug 
infrastructure (default: 16) (uint)
parm:           bt_coex_active:enable wifi/bt co-exist (default: enable) 
(bool)
parm:           led_mode:0=system default, 1=On(RF On)/Off(RF Off), 
2=blinking, 3=Off (default: 0) (int)
parm:           power_save:enable WiFi power management (default: 
disable) (bool)
parm:           power_level:default power save level (range from 1 - 5, 
default: 1) (int)
parm:           disable_11ac:Disable VHT capabilities (default: false) 
(bool)
parm:           remove_when_gone:Remove dev from PCIe bus if it is 
deemed inaccessible (default: false) (bool)
parm:           disable_11ax:Disable HE capabilities (default: false) (bool)
tavla@tavla:~$
tavla@tavla:~$ sudo systemctl restart iwd
tavla@tavla:~$
tavla@tavla:~$
tavla@tavla:~$
tavla@tavla:~$ sudo journalctl --no-pager | grep iwd
Okt 30 21:10:42 tavla sudo[1206]:    tavla : TTY=pts/0 ; PWD=/home/tavla 
; USER=root ; COMMAND=/usr/bin/systemctl restart iwd
Okt 30 21:10:42 tavla iwd[470]: Terminate
Okt 30 21:10:42 tavla systemd[1]: Stopping iwd.service - Wireless service...
Okt 30 21:10:42 tavla iwd[470]: [DHCPv4] l_dhcp_client_stop:1264 
Entering state: DHCP_STATE_INIT
Okt 30 21:10:42 tavla iwd[470]: Removing scan context for wdev 2
Okt 30 21:10:43 tavla iwd[470]: Removing scan context for wdev 3
Okt 30 21:10:43 tavla iwd[470]: D-Bus disconnected, quitting...
Okt 30 21:10:43 tavla systemd[1]: iwd.service: Deactivated successfully.
Okt 30 21:10:43 tavla systemd[1]: Stopped iwd.service - Wireless service.
Okt 30 21:10:43 tavla systemd[1]: Starting iwd.service - Wireless service...
Okt 30 21:10:43 tavla iwd[1212]: Wireless daemon version 2.3
Okt 30 21:10:43 tavla iwd[1212]: Loaded configuration from 
/etc/iwd/main.conf
Okt 30 21:10:43 tavla systemd[1]: Started iwd.service - Wireless service.
Okt 30 21:10:43 tavla iwd[1212]: Wiphy: 0, Name: phy0
Okt 30 21:10:43 tavla iwd[1212]:         Permanent Address: 
60:f6:77:df:20:c3
Okt 30 21:10:43 tavla iwd[1212]:         2.4Ghz Band:
Okt 30 21:10:43 tavla iwd[1212]:                 Bitrates (non-HT):
Okt 30 21:10:43 tavla iwd[1212]:                          1.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                          2.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                          5.5 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         11.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                          6.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                          9.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         12.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         18.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         24.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         36.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         48.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         54.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                 HT Capabilities:
Okt 30 21:10:43 tavla iwd[1212]:                         HT40
Okt 30 21:10:43 tavla iwd[1212]:                         Short GI for 20Mhz
Okt 30 21:10:43 tavla iwd[1212]:                         Short GI for 40Mhz
Okt 30 21:10:43 tavla iwd[1212]:                 HT RX MCS indexes:
Okt 30 21:10:43 tavla iwd[1212]:                         0-15
Okt 30 21:10:43 tavla iwd[1212]:         5Ghz Band:
Okt 30 21:10:43 tavla iwd[1212]:                 Bitrates (non-HT):
Okt 30 21:10:43 tavla iwd[1212]:                          6.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                          9.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         12.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         18.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         24.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         36.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         48.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                         54.0 Mbps
Okt 30 21:10:43 tavla iwd[1212]:                 HT Capabilities:
Okt 30 21:10:43 tavla iwd[1212]:                         HT40
Okt 30 21:10:43 tavla iwd[1212]:                         Short GI for 20Mhz
Okt 30 21:10:43 tavla iwd[1212]:                         Short GI for 40Mhz
Okt 30 21:10:43 tavla iwd[1212]:                 HT RX MCS indexes:
Okt 30 21:10:43 tavla iwd[1212]:                         0-15
Okt 30 21:10:43 tavla iwd[1212]:                 VHT Capabilities:
Okt 30 21:10:43 tavla iwd[1212]:                         Short GI for 80Mhz
Okt 30 21:10:43 tavla iwd[1212]:                         Max RX MCS: 0-9 
for NSS: 2
Okt 30 21:10:43 tavla iwd[1212]:                         Max TX MCS: 0-9 
for NSS: 2
Okt 30 21:10:43 tavla iwd[1212]:         Ciphers: BIP-CMAC-128 CCMP-128 TKIP
Okt 30 21:10:43 tavla iwd[1212]:         Supported iftypes: ad-hoc 
station ap p2p-client p2p-go p2p-device
Okt 30 21:10:45 tavla iwd[1212]: [DHCPv4] l_dhcp_client_start:1219 
Entering state: DHCP_STATE_SELECTING
Okt 30 21:10:45 tavla iwd[1212]: [DHCPv4] dhcp_client_handle_offer:811 
Entering state: DHCP_STATE_REQUESTING
Okt 30 21:10:45 tavla iwd[1212]: [DHCPv4] dhcp_client_rx_message:915 
Entering state: DHCP_STATE_BOUND
Okt 30 21:10:45 tavla iwd[1212]: [DHCPv4] dhcp_client_rx_message:948 T1 
expiring in 431999611 ms
>
>>
>> I always get this output:
>>
>> -----
>>
>> tavla@tavla:~$ sudo iw wlan0 get power_save
>> Power save: on
>>
>> -----
>>
>> Interestingly, this the following seems to work (but is not permanent):
>>
>> -----
>>
>> tavla@tavla:~$ sudo iw wlan0 set power_save off
>> tavla@tavla:~$
>> tavla@tavla:~$ sudo iw wlan0 get power_save
>> Power save: off
>>
>> -----
>>
>> Thanks,
>>
>> Martin
>>
>>
>
