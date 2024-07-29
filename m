Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45512145FE1
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256736; cv=none; b=s1bLxxZNsR3kbdfRiLkOP+koEKTZ1um5QOvhcgqJ7NfI036mfnjt2cegg0pIRNcuvSC5DqIJMhswADsdcrghkclS7IXO0AcePWB91N0QO1mdTXFaYzey+OKs3nJgrDz3665OkYkIA/ZZo8mGKJbbmRc886VplybYL+m2aRg1w+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256736; c=relaxed/simple;
	bh=x8SNYoPXzDoqsaKvwdysQIfWV7k/FMvAgrpMBWOdDI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQDqWdDS996qvHm0dSQF6wEurDziUwDgeSAnwpEmk90pU2vhD4ntvvPuagHSLU3DvPvyHNLB8T6f7pEsxzYxub4KrwnU6IyGWeK1SemfYS9xZhGYFQ7PX9w+zNCh/ygkakm0+jU03p5Fn0SQIfRIp7Z74BhsHWXRHnoQKQb95vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ/RRr1n; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ/RRr1n"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b79c27dd01so18641086d6.3
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256734; x=1722861534; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTFiaFiQBwnM9n+HSNaMIpGnCc9L5h1ptTe1cLdckJg=;
        b=RQ/RRr1nj0Osl1UERmo6T+XfV+TsgRFBq+6PVVHHVC3acn1HHD13ciEslJgNn2uqBv
         6/82G8qmKY2wNCd0NnI5iikKKAwy+q7mvUN6b0soaR+4S3cALFaGx1mPbMVr70Vq6rqE
         +z2lgkFHvWqq+T8MNjLEJW36iXqSaIBDlLxsXUzMpccnhyFHETdxCFOJVBBSRy/dqPGj
         CxlQ/aywygILC9JbdRRw6A0tN8ymAl8XRzXADoWa+yWSTJP9qBplDdIMHC8SUkmMPOoD
         Z/NhKED/VglbpSp43DkESlncTZPbJ1wZ4ez3LuywbU1Lv8XpVX9646dfQ6OGfHHjOogP
         xTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256734; x=1722861534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTFiaFiQBwnM9n+HSNaMIpGnCc9L5h1ptTe1cLdckJg=;
        b=jfrGnXbuAlBVsIGZLW7M+lssHlzB8w7ow54/4A38uzLLPGpZq9h3v62To5a8ufBl6+
         2nQ0euonSNXxxaecb8ZGYOD17oSQOyVKXR8txrPJGqTQ3B4qxxLA0lqAIH8cXpf9s0jn
         yl6FREjrLxS+8e47KzgO+YTJNMbnlV+gewJuwhg7Fev5d9BfWMGb6ByFRAghstj1gl7F
         IdkjYgtI80tGoEA6tHH2NJvMMZSrj1s6xO0LVj9oJmxtQ5exG2AaXU1ciVdEbWk3WMXp
         wHqf/LmImSwatcSt6JeZdpbOGMnFKtnuovVnXTmNBrf/UhoWb57wY/WQbU/qu69HLQGm
         p6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm8oMBGRnKIUkl0j9tbUxS85mEzTCdotpvbpzOEFuLOrqLLye5PW9clsPNRGoV4zh0MRnoez1ctch/Gxjy0GRu9Pp7
X-Gm-Message-State: AOJu0YzDG24B6lsjQln09VR2rYUJIJ+GqdAnevHODxJtQVyi+vQpYBIT
	zmrfo9vxmxVr3w0PMidBSubncZ3VQWNUygOxXqw053iYZE8Kto1P
X-Google-Smtp-Source: AGHT+IH+SycnpdfGRwOS1B5wJM02dozo8K0IkglD3s62z9+wt5eKWKe3bBM6qy0Dk4spZxAfFeyF3Q==
X-Received: by 2002:a05:6214:2401:b0:6b0:76f1:8639 with SMTP id 6a1803df08f44-6bb55aba950mr122986526d6.42.1722256734165;
        Mon, 29 Jul 2024 05:38:54 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d82b7sm50811316d6.28.2024.07.29.05.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 05:38:53 -0700 (PDT)
Message-ID: <e0b71ad0-0fcf-479e-b976-0f84d36a88c2@gmail.com>
Date: Mon, 29 Jul 2024 05:38:51 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Frequent Disconnects / Roaming Issue with IWD + systemd-networkd
To: Martin Petzold <martin.petzold@tavla.de>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Cc: Denis Kenzior <denkenz@gmail.com>
References: <85ef594d-d928-4d12-8741-b3d897c008fa@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <85ef594d-d928-4d12-8741-b3d897c008fa@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 7/28/24 11:53 AM, Martin Petzold wrote:
> Hi all,
>
> this issue is related to my previous issue, see [1]. It seems quite 
> sure that BSSes are blacklisted and, therefore, do not re-connect or 
> re-connect after a long period of time and then lose the connection 
> again. I cannot tell the exact reason, still working on getting some 
> logs from these devices.
Yeah I don't think there is much that can be done without debug logs to 
see exactly why.
> Changing the blacklist configurations helps in terms of the devices 
> coming back, also adding "IgnoreCarrierLoss" in systemd-networkd 
> configuration seems to make the situation better. However, still 
> really bad!

So fwiw if you suspect blacklisting is the issue you can always lower 
the blacklist timeout very low. For our use case we have it set to 2s, 
only to ensure the BSS gets blacklisted for the remainder of that 
connection attempt. All our clients run on a known network 
infrastructure though, which may not be true for you, but disabling the 
blacklist (by setting a low maximum timeout) will only cause IWD to try 
connecting again after certain failures.

>
> I have now updated to most recent Laird firmware (11.x), IWD 1.27 and 
> systemd 252. The problem still exists without any difference. Of 
> course our customer now also investigates his AP infrastructure, which 
> also could be miss-configured.
>
> This issue is especially present with multiple AP with same SSID 
> (typical roaming setup). But also present with single router. The 
> signal strength of the APs is usually low between -60 and -80 (and may 
> change also over time - closed doors etc.). We still have a stationary 
> device. Maybe it is jumping between AP and then blacklisting these AP.
>
> 1. I wonder if the problem could be related to systemd-networkd 
> managing the network interface and DHCP?
Hard to say without debug logs.
>
> 2. What is actually your recommended management configuration with IWD 
> + systemd-networkd (1.27 and 2.x)?
This really comes down to personal preference. I prefer using IWD 
because it removes one more dependency but there isn't any problem with 
using systemd-networkd either.
>
> -> Like everything should work, especially Wi-Fi and also roaming 
> scenarios.
>
> 3. What does IWD do using the "RoamThreshold5G" value of "-76" and 
> with two APs and same SSID (roaming) with slightly lower or changing 
> values?
If the current connection drops below the threshold IWD issues a roam 
scan, and if there is a better AP out there it will attempt a roam. If 
no better AP exists it remains on the current, even if the threshold is 
below that value. As long as the current RSSI is below that value IWD 
will continue to scan looking for a roam target.
>
> 4. Is the following configuration correct, if I want IWD to manage the 
> network interface and DHCP, and still let systemd-networkd knowing the 
> interface?
>
> -> I need the *.network for wait-for-online triggers and also because 
> I am reading out the network topology using networkctl and there is 
> also an Ethernet interface.
>
> ##### /etc/iwd/main.conf
>
> [General]
> EnableNetworkConfiguration=true
>
> [Network]
> NameResolvingService=systemd
>
> [Scan]
> InitialPeriodicScanInterval=10
> MaximumPeriodicScanInterval=60
>
> [Blacklist]
> InitialTimeout=60
> MaximumTimeout=3600
I would suggest setting MaximumTimeout to something low, at least to 
debug if this is indeed the issue you are seeing. If APs are routinely 
failing to allow clients to connect they will be blacklisted.
>
> ##### /etc/systemd/network/20-wlan0.network
>
> [Match]
> Name=wlan0
>
> [Link]
> RequiredForOnline=no
>
> #####
I'm no systemd expert, but this seems fine. I think as long as you don't 
set any DHCP settings in systemd it should work with IWD managing the IP.
>
> [1] 
> https://lore.kernel.org/iwd/8c7ff992-2f03-4e4f-97bc-36eab3727d44@tavla.de/T/
>
> Thanks,
>
> Martin
>
>
