Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8174C05
	for <iwd@lists.linux.dev>; Tue, 26 Mar 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452835; cv=none; b=RgAORIvvqkSumXUMBSWcDWjiWtpxvcsWob0e0CsUrSNzn6XDYlmAr8QnA7tscxm29TTgbqz1E2TbJEkabLh1m9kf5S4gZ6c77d7JjzeH+GJAZpcLDjmqKd7+7d3fnZFQm9UmZTsJyQBqKbLACS8sGQg8CxAYRU3lZb9Fiaf/XJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452835; c=relaxed/simple;
	bh=nHaXlK3A8rjdFORKi7yjx+f5LiAdgnu6qAVdpxtsq24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSVmi2kZIdueJ47UOpQUfEVO9PI71h4Kz63fm6yIStKwxQOBUMfh9YAZ3PUT3sJPmd4BfmXo/tKE3lcr2W3cbs/FR/PE6CyTWd2fpRPG/FXyGw/DcL/b5HeGSOijso4ZE1aJ7V2ae+SVETnAJAB/Dg3b4kYeXdRMXchgcj+6vuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA5XBU2W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA5XBU2W"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a5580333bso127065185a.2
        for <iwd@lists.linux.dev>; Tue, 26 Mar 2024 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711452833; x=1712057633; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGgxYUYrMMip/0epcQmNXPz5eZPCuXWQ18Xp7jNdN3s=;
        b=RA5XBU2WwP6b7Mf5inI+cqEqJXirN4ZwHuz8dn6gUm+4/4KDC7u64nuWTX9wAnOWAC
         HYp+v2atoiN+pa9IhAbFd9m8pyihb4HGNfjIg8EKBxfsZ/zhrsRLcjm56lQLX3VmSS0+
         I8xOtlRuMhniIZ1hlg0Uhnn+9RDnJMJAPru7g0g5eHOvJ2JnFWuk4Z+rRx2QvMFAwuq/
         SXbdrqTOwVWNED0W0jK2SCL3hNQAPE4IbfVtqia/l/dXJ1Q4Sr9B2+09ThWTEsdebbhy
         RWX11ucvGGzrqB66dngJtkS7G3KPJZgatx6Tdz44HYNz4OK0EjGEUvPwa+/Aw5nG2JbA
         pKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711452833; x=1712057633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGgxYUYrMMip/0epcQmNXPz5eZPCuXWQ18Xp7jNdN3s=;
        b=uygTb4kZPFEidN92K4GqLuMCL/yo6pFGoigLEuQlDMaaSoTlAyxnq66fRnjgfn7Iiq
         fh1Hzosa8zJTg7rfkuWfUxFhpAaU5G5XooaygDcWHCOTpz/QC75LyM3bapGNBlYDlPBm
         jr+/iAgo69s8uq7zlWaalX0doR1LnwW87cDV2qRmGO3b582g3SfQT7XGdlTSIURqBoFG
         0FOKkwRZlqi32gEXNXS7TY7k4XF7sNXsK5q//KDVOaILqFkbRkoUEIfLuarGPMyykOIO
         wERgjt5OghVaNDL91Io4ctowK/G3DpY4hi67YBvHhMGa9nufCiZnrNdEwpDe+4DrLJbk
         SXPg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSXv94nlGKSl6dJwzIO5cL9azZLDQoQgxCG0c0JByFyTAxthMZSFJWv5mT6RoMI59c0h/09/nc/p0ys4ZUpPLAjjY
X-Gm-Message-State: AOJu0Yz9c8oS+UpvIV1zjynTfMybWeFn3XW9/J8MbCQrB7Q038M5QPFl
	GLbygTGVq5XPtfSnSpfpwx4R0WVLbD1N3tkY/fwhnQBXXsC/NM1L2epwDB+m
X-Google-Smtp-Source: AGHT+IGNDXO8XeatbAQBGt6OoTA7e4A3vBuwm+hX7/AH94r3723tEKPO5YZaMu2JsxmrefyXilysyQ==
X-Received: by 2002:a05:620a:a86:b0:78a:5927:607c with SMTP id v6-20020a05620a0a8600b0078a5927607cmr4713902qkg.4.1711452832791;
        Tue, 26 Mar 2024 04:33:52 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id k22-20020ae9f116000000b00788481cdf4csm2939954qkg.111.2024.03.26.04.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:33:52 -0700 (PDT)
Message-ID: <fc1a740b-41cf-48d4-a95c-3c733801b672@gmail.com>
Date: Tue, 26 Mar 2024 04:33:50 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ios hotspot fix
Content-Language: en-US
To: Jeremy Whiting <jeremy.whiting@collabora.com>, iwd@lists.linux.dev
Cc: Edmund Smith <ed.smith@collabora.com>,
 Alvaro Soliverez <alvaro.soliverez@collabora.com>
References: <27b427-6601b380-b-46ef6f80@167641064>
 <bba319c4-6e65-4809-99d4-90019b89a89e@gmail.com>
 <bfb5d799-65bb-412c-be32-3ceea0211968@collabora.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <bfb5d799-65bb-412c-be32-3ceea0211968@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jeremy,
>
> The bug we were experiencing was only on the OLED version of the steam 
> deck. According to lscpi it uses this wifi chip:
>
> 3:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 
> Wireless Network Adapter (rev 01)
>         DeviceName: Broadcom 5762
>         Subsystem: Qualcomm Technologies, Inc QCNFA765 Wireless 
> Network Adapter
>         Flags: bus master, fast devsel, latency 0, IRQ 77
>         Memory at 80000000 (64-bit, non-prefetchable) [size=2M]
>         Capabilities: <access denied>
>         Kernel driver in use: ath11k_pci
>         Kernel modules: ath11k_pci

Interesting, this is the same chip we have several devices running and I 
have never seen this behavior, granted I've never connected to an iOS 
hotspot. So maybe iOS does have some hand in it. This might be something 
I can reproduce when I have some time to set everything back up again 
because I do have this same chipset here locally.

fwiw the firmware we've been running is: 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36

Thanks,

James


