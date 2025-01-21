Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E061F1316
	for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467453; cv=none; b=FbD2yuRZfERLhi2XQehDXzd2m2chOn2Wqj9lpjAvCSpqDEYuM9rALz+okRnZSCYUz6bZLXE8XogdPmq/s9sDShThpOkGlS1oVwEr8oSWsL2tz7X1RZxUTk53wGBNtmvwROrv4fQfN5FCVPG3jFzsuIhLgKHv+O0mbhWwWYXqA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467453; c=relaxed/simple;
	bh=/w1OgZdETaHG4j4aYezIBHCfz96/5N6ZBnpuS1NvRTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqrzluzXqA4B5j3CtoURqkET0tjnvvUbPA13C+qvZ/AoZBPlVab8S7uMYl3jIKcY4JQyF9aSJIDIFowDKxYHsUvEg0NMvGiFdUX7tMzkoEPPua6qewCJsR/s4nR66D0v4n0oAyhekO/Vb3mY070lkhtmRkkLHXy67FRafokhL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfzH71g4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfzH71g4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso104362775ad.3
        for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737467451; x=1738072251; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVzooEy6nkfi45DGSb94sOM2hrjUk8SLVi1DTsfPDOU=;
        b=LfzH71g418OZEx8Gi3XsJ9OAV2dpTbEQyzo9NXMoutdDLX50KjBexQsSxWBFYYVeQ6
         Q7A0jhSdy7kA/EqvL5tgvVu1fmqx77BkxtuN8FNOCJpSS7JXYUyhw+YrGoyoOi1wRtpR
         FPtom/k9eRqGNXmKXYKlXle7Td6TYjJTxDH/Ne3GMjRsO3ooxSpOH9U0ZRI7iM6A/830
         lajDrxAeeCEcUgqDLMNHDe9xGAPIN8xJQeTDZEGNO8lz7FUIgDKItrQsat40BhlI3+it
         aXofKs/xrEIR++BfcuwXpAwnB/EkR8dA7F9zxZqj4//eCfbPEOgV2wbpapWM9zPLRTn5
         6j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737467451; x=1738072251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVzooEy6nkfi45DGSb94sOM2hrjUk8SLVi1DTsfPDOU=;
        b=Xu1RlNfBb705qc4MyKfPzdpyv4GBYpV+hC++Ab+9FkaYVrFwf3mMwYlGVHdpI0+MWZ
         a3AoPNj66h2w28GCfITPJRoHheBZf7MU0rRJ2+odF7oXjGEkWx0vVZY1luSffR2wsGLC
         ivaEnrRKDTKiI+udFPKp8cNx++P6iVRkWLejKT7SagcIKeVYihAMWzhW+ejhW1Ig1wBz
         N53QYUCP2jsbktkRIP5GFwdRGaY+j308DjwVyFbw2hb9x6tvwzkp036hpADLiQOauXam
         ai5go0AyHn8NTiArqjkL3wpkU13lFW/kQKqY9yc3HPC4OY8onmjAalSTdgVyKC0h5NOA
         7gMw==
X-Gm-Message-State: AOJu0YwEXdimK0mcKHEnqwUa/hNU6W6e7DFrmExGa24ROPjt6VomsCTz
	FTOTZU9wCNzopNSBmx7mnQ+2sbDgawwxXYyaMzjFD+k6Kvhr+vI8
X-Gm-Gg: ASbGncvbd7pQo67+C4yfiNBkOxZMOO3d4yfZ2Fu+IvFjzocKIq4wPm0hUEg9aHUip78
	E/dvVNxaGzCzGtYH53HkgzujIejbjKr6qJVxd+d22wecQtPN+DZtdOjoNDe49XkBIYZhg6tzg0Y
	RoKmyn55qWiQgtjIXdrRMq2LPuZrF7cvexJczJ9lkPhUCKDg0T4KQ7h99TNqA96ejXZlrqOiPlH
	HlCToDF5xEO4IrpagmRpcqlBeviyOIf7mQGZE2OJ7qy/CqvjuvMGssN25APZNXg6xE97s2rGpIU
	NxeTaiNwXolhvCO/SPGilNqFciFO7ISEL/csBvg5aWI+d/gG
X-Google-Smtp-Source: AGHT+IEGRNhfJmFj3XdWJbigwU54axeaWVD4MeoLgeUEUkOZpeP9K6i/zoueSoq6olF07bORTNLhzA==
X-Received: by 2002:a05:6a20:a12a:b0:1e1:f281:8d07 with SMTP id adf61e73a8af0-1eb2147e1a7mr24155566637.10.1737467450809;
        Tue, 21 Jan 2025 05:50:50 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc3232a4sm8839603a12.30.2025.01.21.05.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 05:50:50 -0800 (PST)
Message-ID: <ba94e034-df99-41c8-8da6-3ddaa3fb1f66@gmail.com>
Date: Tue, 21 Jan 2025 05:50:49 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to triage an "Invalid Key" error message?
To: Christian Hewitt <christianshewitt@gmail.com>, KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
 <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
 <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
 <578421A3-35DA-431A-9319-96D847AA4CB2@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <578421A3-35DA-431A-9319-96D847AA4CB2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 1/20/25 7:36 AM, Christian Hewitt wrote:
>> On 18 Jan 2025, at 8:38 pm, KeithG <ys3al35l@gmail.com> wrote:
>>
>> Christian,
>>
>> Is this, perhaps, on devices with the brcmfmac chip? I have seen this
>> recently with on my Pis with wpa2 and wpa3 APs.
> The majority of reports are from RPi 4/5 users which have brcmfmac
> chips, but 85% of our distro installed base runs an RPi board so
> that mostly reflects our demographics. I’ve also seen reports on
> Amlogic and Rockchip SoC devices (also using brcmfmac); but to
> offset theories on it being brcmfmac specific, we’ve also had
> reports from users with Intel iwlwifi hardware and someone using
> an RTL8723BS chip. So it’s more likely to be an interaction with
> common code not driver code.
>
> At one point we suspected an issue with WPA3, but that was triaged
> with RPi developers and we now disable SAE offload which allows
> boards to connect to mixed WPA2/WPA3 networks, see:
>
> https://forum.libreelec.tv/thread/29155-rpi5-network-disappeared
> https://github.com/LibreELEC/LibreELEC.tv/pull/9477/files
>
> In the following forum and GitHub issue threads. There’s lots of
> assumptions, guesswork, and false conclusions, but among the noise
> there are some snippets of iwd debug log:
>
> https://github.com/LibreELEC/LibreELEC.tv/issues/7166

This one actually has some iwmon logs. Looks like the kernel is sending 
a failure within ~100ms of the connection which is odd. IWD waits for a 
successful connect event before starting the 4-way handshake so its not 
even getting to that point:

< Request: Connect (0x2e) len 172 [ack]                                
5.644853
...
 > Event: Connect (0x2e) len 36                                         
5.735838
     Wiphy: 0 (0x00000000)
     Interface Index: 3 (0x00000003)
     MAC Address 00:00:00:00:00:00
     Status Code: 16 (0x0010)

There is also a core dump attached, but the back trace isn't of much use.

> https://github.com/LibreELEC/LibreELEC.tv/issues/8731

This issue _appears_ as if wpa_supplicant is also running along side 
IWD. That is generally why you see this log:

Mar 16 21:10:35 pineh64-b iwd[1046]: Unexpected connection related event 
-- is another supplicant running?

> https://github.com/LibreELEC/LibreELEC.tv/issues/8760
This seems the same as #7166.
> https://github.com/LibreELEC/LibreELEC.tv/issues/8762
Not a whole lot in here, but apparently resolved.
>
> I’ll need to rig a distro image for greater debug (as per James’
> instructions) to see if we can obtain more log output.
>
> Christian
>
So overall the "invalid-key" issue seems to be due to brcmfmac 
signalling a failure very early on. In a perfect world it would be great 
if we could capture debug/iwmon logs of both IWD trying to connect and 
wpa_supplicant, so we can compare the iwmon logs and see what each 
supplicant is sending to the kernel. The messages _looked_ ok from IWD 
but if wpa_supplicant works fine there is obviously a difference 
somewhere. As Keith knows, brcmfmac is kinda a pain to support as its 
the odd-ball as far as drivers go. IWD doesn't get much contributions 
from wifi vendors so any odd quirks only get solved by trial and error.

Thanks,

James

