Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676F33CE8
	for <iwd@lists.linux.dev>; Sat, 19 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348904; cv=none; b=ebFd6bq162yF9psCYMf9Q/o1VtqY1WXly5tq9H3FSu0l2mis6YIlnxp1JKzCMiYMrWKZBegyD/QEoUV3nGvVIyg4bQzOOqkzgBNCvsdixBZTyzLB2+s+vtt5jV/DftTHF/+e1sv48D+h1rTJ1MUqe3ODzY0mxQpeoXQneSdUO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348904; c=relaxed/simple;
	bh=rytb50V/R5UUD9ICDToWkr3imftFmEXQEsyTj/poBxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0l6s6Pbq0E4sLW1jtdUlnqGOxlfL/xmgwjV6Ia+LgB/3ek+P4yuAOawiFjWQi6Sf77xqIfbAVs6vHDQ2Per5Nt13M2Rdb8QK7V3bUdnXOlHbDFC3RJhdrcaJYCkNe+OSb7qeaD+94bCUQAnWgYcicLDviCxS6ZlgRQzxLQRRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIS1rIMs; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIS1rIMs"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e5d0a80db4so1555328eaf.3
        for <iwd@lists.linux.dev>; Sat, 19 Oct 2024 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729348902; x=1729953702; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDuvifj0mB98p5xVSdNwR0ZsSWc4ScV3JEEBnBk45rw=;
        b=RIS1rIMsRRBvCJfOuUFSJiQRuKPVcNqNUFs/uVLjRWqZrwIE9n6l1fc1+VeNYP9U7h
         wriHdw4lSJOH67trK13B9jxRcPHvhb2VdAlBU2yvNGAsTk0MELlaah/984GGFZG53W6R
         s73exooBoLFvxtoBZvBRdk4639Up6SXk6i4kD9KAikEG+eEL90eL/Zc/WZAXD/OI5IRe
         VHRpownxXtGJzgAz+QFgfKYJnYMUOx2EDF0E1HbCkcszgP46GPZ/+Wcfm2iOsO8YbFM0
         95whVQVnk/2wwj04uWLDEp2nWNBiPewRpy4eKfc9NHP2l8+2RsJLjuCkmyNTon1kQC32
         RXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729348902; x=1729953702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDuvifj0mB98p5xVSdNwR0ZsSWc4ScV3JEEBnBk45rw=;
        b=Kl5Ppt86ZImcJAiqmXZxA2xYsfxQC/EudQgPVLTNHqAn4H/SWgLfawH3UBSuKabF8z
         NDUP2DrxEJtbp4CrOm4ge1iX/Lxm0VSKw60SJ9UzzP2yD+fFpPjAbGAUkBN5gBCsgUhi
         h1B7HNP9d7bxo/iyb+DKx4P3b/UIsG85gJysR6WFK5hJg46bj1cIp3EtjLHNDbzk/OFJ
         dr9la5ZaY7+wstW1wK/y2KagnK5ljAUp/q4HHl1yTqQXHKn7WFXgfBD5k2RZxPFqCrTV
         TaeSvYrMi0x+3NHfSGNi/wWHzFZt7arcLG6QaqSWmh/tArZlv/SsiwQEx5UIMl5WFN2z
         gaqQ==
X-Gm-Message-State: AOJu0YwH0FITP3+PpnonU8JSA8p6Ha3BrEf5bfZeTScPjn/7zuoBv00o
	pLzP/+3FglvipmW4ZZlVcAAnXpyNTYow5EY5CZp+uRtFrGnwxkNp
X-Google-Smtp-Source: AGHT+IEW+JVdZkfGS3tXVPBlEE7tqmu78/lwCPZLX0BPheFP1i+9si26Mkibi4mzkWkEnHQv1nXoGA==
X-Received: by 2002:a05:6820:822:b0:5e5:7086:ebed with SMTP id 006d021491bc7-5eb8b6cb95fmr3540107eaf.7.1729348901890;
        Sat, 19 Oct 2024 07:41:41 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5eb8a7789ddsm630518eaf.5.2024.10.19.07.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 07:41:41 -0700 (PDT)
Message-ID: <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
Date: Sat, 19 Oct 2024 09:41:39 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> Additional information about our setup: We do OTA rootfs image upgrades. So the 
> whole rootfs (including /var) is replaced. AND after reboot we always have a 
> fresh setup an initial boot again (systemd "firstboot"). Here also machine id 
> and other things are re-created. We ONLY preserve the "/var/lib/iwd" directory 
> (and bluetooth etc.) on a separate partition and use bind mounts (in fstab) to 
> include this path under "/".

What you describe is standard practice.

> 
> So maybe for IWD it is uncommon to find a "known-network" on firstboot 
> (typically not possible). Or maybe some kind of BSS information is cached and 
> then gone because of our rootfs upgrade. Or it is about the change of machine id 
> (MAC address in our case remains the same, because it comes from the chip). 
> Maybe if you have a known-network, you assume the BSS cache has to exist (been 
> built) already. No ideas, something like this...

iwd does not make any such assumptions.  No information is kept outside of 
/var/lib/iwd.  The only cache iwd keeps is of frequencies for known networks 
kept in /var/lib/iwd/.known_network.freq which is used to speed up the initial 
scan.  If the file doesn't exist, iwd simply falls back to a full scan.

> 
> This is a more or less common setup for embedded environments. Would be glad if 
> you could double-check if this could cause wrong initial connection (weaker AP).

We can't help you unless you provide logs.

Regards,
-Denis
