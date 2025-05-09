Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DB291874
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796349; cv=none; b=aLXxGSHxPx2Z1LibgzhsOt0x6hGyBrIG5IxNS/DADBEgGXoOaX2huKRtIUn6j9UNxer0fE4ie8bFbAl0G0RK5W2mxWPo7vo3mwqGrrMk/ekw9hqJCY4WoxcMbOwuSoAnWaGF1h4XwGBPqgJdB/ecTQjKRpWkBNFsq3ZZTOYKZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796349; c=relaxed/simple;
	bh=1WWyjB8u7UlIiW0KwaclRdlUJn1ij8nqZrTMpU5aJ7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odhZmuOo9Dvvy2XUB7yWxqXp5MqI6bJtXzZndD0F54Pya1zH2Nu1CS6UwU/ZN6SryKRo1tpMiCKtfb46JXA/DMWH6DugQHNv4NVzGMYPQTPcOdSeYIq3yArCynWJTkKDsEvl+tPbgNyCdq5ose6E6duv1fiLxbYeWU91CvUFI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLMwVLJM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLMwVLJM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47698757053so27973721cf.0
        for <iwd@lists.linux.dev>; Fri, 09 May 2025 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746796347; x=1747401147; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNTsk+ubj/Qw14Ek/kIvcy3QgaxEnCDA58EUUDDrPi4=;
        b=VLMwVLJMI7yAeBoNu6RQ8fH8SgCD3ubHkLTwoPyr8Qwct8mk8UdUPNVFMmkatudysN
         OfGnmc3Gf0dVKZF9nnBA1RdveeRyOec2aMKuIpNx2/2jB6QRMI6Rzdk/Q+L8WHYxi34N
         hz0DMO30RvQcGPhRhlA3WLt0VfQBD/AlWDSFXY/rBitwulSYkX0D+haH55IZ5hvZQbxN
         gkJURjyi9fBJrbzjhOBGatH5IhGHvyN6Pvs6gpkKqH+rVpsDd/cDfO67chwp8iYKmcD4
         65gkQ7emdpAW4ly3CkiU441KgRNmaxYFJ9mgdIpJlcKhRgkSo3Kk56SfXA0zQKPsQnxR
         pgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796347; x=1747401147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNTsk+ubj/Qw14Ek/kIvcy3QgaxEnCDA58EUUDDrPi4=;
        b=UcoqrtPpZRcB7pzX0Am6M5StHT696Q6fwBt1SNNpr1FnqYC+zjFS5sxK608ox3+P3P
         1C+7c9J+Dw9w2dLEwYY/nf3lC+RSFf1zBrcaB1ERa7eCOupvO1WLqlRdSvJ/j5v5tfGi
         jraak/aPmGLzQDV2l3pPOz6ORMghrLuwEDtn6MpG2zLNy3iqSR+4Xuety/GPmGdYD3Qt
         NODJAcu+PoFdYiCLcPKYnfOdimdKwbu+vKg1muqTUOK5exFL+GtBFB1KSriY//CxGCBS
         RTJotQckTn51pTSfLrF1yAEOOJIRSwb0ufpujSZKuVFvrxQTPNUoUrB+2BqDH6fyTmZN
         v3gA==
X-Forwarded-Encrypted: i=1; AJvYcCWTQ0uSM6l3zzlhcdf5qOWQaC7XqLdAaqIE9HdPzZIe+Oi1s53Y18GPeF+8eMa7P7YCtd8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1inNRkH+7DRGQIki9704wCjlvM9qr5nVo2GcxhX+SGxs9bFmI
	KNxPQtYQm7KT7VY8fahfG1xy2zLFwgVeosqhCSrdwbiyBypaasBB
X-Gm-Gg: ASbGncstoC4qeKr4lp3jGrL1D/kTXHic00c4FEiG+CxJZOErAoKr+EZYWN6CCRXeSec
	bAswzVzjTN3Pdpow5V+PaPWKW1/FZ0LCyVJVi6NBWgfIJua4ib/ujjV5hkHgbFMDIr0l6/bQokX
	8btbjt4aFUnfh8SIDu13CbHjuswe2NZhnr7U//M3MVEAleb+PkkToutb4G89ppANxIa1mQGxgiA
	F8n4+s1o/v4PjUMwC2MVN7+1pmCI8wcEuY931uNuH5DtRcBamcIjym6LYeAyz+8vBxLYeqtJyJd
	Cn/ArpqBfMZZW23vuzZpJcZqP+fAl2MXJA/XyObqqE9bTSfIKLHggcY=
X-Google-Smtp-Source: AGHT+IHCyEmUop2zOSnS8rwrCxea0FZ3ATRi1ndV0HoRUnaHD2vfHHixlEa1KLEnZgd0wEe7diHrKQ==
X-Received: by 2002:ac8:5a49:0:b0:476:923a:f1cb with SMTP id d75a77b69052e-494527d50e7mr48716561cf.41.1746796346708;
        Fri, 09 May 2025 06:12:26 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945259bd7bsm12166111cf.65.2025.05.09.06.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 06:12:25 -0700 (PDT)
Message-ID: <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
Date: Fri, 9 May 2025 06:12:23 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Jan Hendrik Farr <kernel@jfarr.cc>, linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <aB30Ea2kRG24LINR@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 5/9/25 5:24 AM, Jan Hendrik Farr wrote:
> Hello,
>
> I noticed that specifically on the 6GHz band SAE connection fails
> on my device most of the time. Connecting over 5GHz works
> (even using SAE). So I started to investigate. Here's some of
> the details about the devices involved:
>
> STA:
>
> - linux 6.14.5
> - iwlwifi (Intel(R) Wi-Fi 6E AX211 160MHz)
> - firmware 89.7f71c7f4.0 so-a0-gf-a0-89.ucode
> - iwd 3.7
>
> AP:
>
> - Unifi U7 Pro (2nd gen, i.e. U7PROP)
> - firmware 8.0.19.16619
>
> I recorded a capture of a failed connection that is attached
> (and also one that worked). Here's my understanding so far of what's
> going on (starting at frame number 834 in the capture):
>
> 1. STA sends commit
> 2. AP sends ACK
> 3. AP sends commit
> 4. STA sends ACK
> 5. AP sends confirm
> - NO ACK from STA!
> - iwd logs show this is never received by iwd
> 6. AP retries confirm
> - NO ACK from STA!
> - iwd logs show this is never received by iwd
> 7. AP retries confirm
> - NO ACK from STA!
> - iwd logs show this is never received by iwd
> 8. AP retries confirm
> - NO ACK from STA!
> - iwd logs show this is never received by iwd
> 9. STA sends confirm
> 10. AP sends ACK
> 11. STA sends confirm
> 12. AP sends ACK
> 12. STA sends confirm
> 13. AP sends ACK
>
>
> Here's iwd logs with IWD_SAE_DEBUG=1:
>
> event: connect-info, ssid: kepler_56, bss: 96:2a:6f:b6:d7:9f, signal: -46, load: 0/255
> event: state, old: autoconnect_full, new: connecting
> [SAE]: Received frame transaction=1 status=126 state=committed
> [SAE]: Sending Confirm to 96:2a:6f:b6:d7:9f sc=1
> event: authentication-timeout,
> event: connect-failed, status: 1
>
>
> Here's dmesg from the relevant period:
>
> [32295.061686] wlan0: authenticate with 96:2a:6f:b6:d7:91 (local address=a0:d3:65:93:5c:47)
> [32295.063142] wlan0: send auth to 96:2a:6f:b6:d7:91 (try 1/3)
> [32295.177571] wlan0: authenticate with 96:2a:6f:b6:d7:91 (local address=a0:d3:65:93:5c:47)
> [32295.178025] wlan0: send auth to 96:2a:6f:b6:d7:91 (try 1/3)
> [32296.093842] iwlwifi 0000:00:14.3: Not associated and the session protection is over already...
> [32296.093940] wlan0: Connection to AP 96:2a:6f:b6:d7:91 lost
> [32297.246064] wlan0: send auth to 96:2a:6f:b6:d7:91 (try 2/3)
> [32298.166457] iwlwifi 0000:00:14.3: Not associated and the session protection is over already...
> [32298.166553] wlan0: Connection to AP 96:2a:6f:b6:d7:91 lost
> [32299.293860] wlan0: send auth to 96:2a:6f:b6:d7:91 (try 3/3)
> [32300.219460] iwlwifi 0000:00:14.3: Not associated and the session protection is over already...
> [32300.219555] wlan0: Connection to AP 96:2a:6f:b6:d7:91 lost
> [32301.338987] wlan0: authentication with 96:2a:6f:b6:d7:91 timed out
>
>
> At first I thought maybe iwd is at fault because its state machine
> assumes that it always sends the confirm first. However, from iwd's
> perspective this is fine as it's all happening on a single thread in a
> synchronous way. So it's always gonna process the AP's confirm
> after sending its own confirm. Independent of the actual order.
>
> The fact that the confirm by the AP is not getting acknowledged by the
> STA, to me, indicates that this is a problem with the device firmware or
> iwlwifi driver. The confirm by the AP also never makes it to userspace
> (iwd).
>
>
> The notable difference with the successful connection (starting at
> packet number 4752) is that the confirm by the STA happens to be sent
> just before the confirm by the AP. All successful connections I've seen
> have this in common. So I think somewhere in the stack (either firmware
> or kernel) this order is assumed.
>
>
> Best Regards
> Jan

One thing you could try easily right off the bat would be to try forcing 
the default SAE group in IWD's config. I've seen some APs really 
struggle with group negotiation which is why we added the ability to set 
this. In your network profile (/var/lib/iwd/ssid.psk) set this:


[Settings]
UseDefaultEccGroup=true

And see if that helps.

Thanks,

James

