Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401E290F
	for <iwd@lists.linux.dev>; Thu,  9 Jan 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432785; cv=none; b=NRTVCRPofn+kuPOruXfpBLHCYEh6rwwnE7sAzohWrrbTKh/8yjV5Qcn7jORpjgbeFX7aqjThVe4I9XoOZfFKgCeaKBi1KmQlRBln6k2+QYGwRTybx8lOFTW2hEWZKSJWD1ww8mdLxUGhh+gZdiQ1U48RI7ASBuUMJWWSYvJENL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432785; c=relaxed/simple;
	bh=1zhzsTnP1KJQXFi685S88b+DCoJnPbF1qHSqDGq+HRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pIuqcENkr1X+x33jL3TSOf/EZtThb30QqIkeAW+SMMmzd3cHJj74pwJdjMiOBfLvI1Zcj24GoYqV+Z1j+G3QYioCZYhrh64RTxDAU5opKP37GNCLX3srWNBXAeGRxpdCJurwt8/QLHAAV1xi3dx48taeCN8r87GMUzeYfriW3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR//heSe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR//heSe"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd1b895541so16369716d6.0
        for <iwd@lists.linux.dev>; Thu, 09 Jan 2025 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432783; x=1737037583; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emF8AnXDqSovt563ZjRSM/b+SlOZL/l87rJfCb1m5qM=;
        b=SR//heSehx1dt6OzUrRn+u+9PYUXN059lQtAJA9lZWIn5L7srl0ODBPOAz6ydWiSO4
         NyBQKd52pnPGp8o73cXGNjky3KjjdKRgBsPT2DgbtLybwgtU1FnL3Jos7AlCdjZxdYze
         tSa/PuE6VsK50i6Kzqhbxj4oNTL8E50vdIt0BDcbU3fMF2lg64zkXAbiIhdCk7ZTeoiL
         yBetlCeWVs/XT+QYKodMibIyRIaCYsC2Z/Wt3XKgFRfrUjZHwVpPRP6VJ7in7B3hV8sY
         6VniRIzF4ONqv2dwGV5Gqq7mze8DR1BKEWAf5KyFAZmuC5ocKe5KnUkhWuXvfniViJjl
         v0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432783; x=1737037583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emF8AnXDqSovt563ZjRSM/b+SlOZL/l87rJfCb1m5qM=;
        b=DrIPh6wk+GK/1pUNbiS7D8+IiZzNWwPdR5DRI7xmg8qsimDzzlsWveMuN9CXtb5DNW
         o0K2TxViyATjB4K5ryHKgLMe30U2oIRMInIn4l0jWj7n0MUC0Ghykt5Yx0nnf1ld5QcX
         dKQ758dIq4QVCMph7tjLSL9CWrQB6oWvti/DYSXxTnqAnK3P+Bol4EuCn9dcfEspduta
         XzWqwzTftYz1S3MzWwAALQmW486XnFTOs+XTNRsdXyhOw0DiH224JU6W5PimZCsILA7E
         /h0iBNqgpk7dZYgHa7NL/al2r8cU70RMgPH4kqVg7NYzD3SN/NUWLdRCGhNBtFNLvDHN
         YJog==
X-Forwarded-Encrypted: i=1; AJvYcCUOqSsHZpLp+INUiv+KOnxyOInxbV3lPTWfqJJtSXiyRXQj7NAjIvtyzhk0g6Aqc2uaxKE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4Nz/UN6ARJjx4hvbBLXBFRsWQ+pog33yP8yAQdbckKX+5jUzq
	izM4Z7rka3e9xRnT0o/5qpcYMuBH2XyUR/bwyrC3bD5C62D1WtDpt3jJ+g==
X-Gm-Gg: ASbGnctWjDHY+DoGVHqVRFBsljuaN6rC2wUlPoj2DmthrXIM62dzf+qoOvIyO9yFS1s
	htZRo234ryfCMkx1679gfM3DxHtpgpLqcxCTXe57+SPtDpL+n2Jli0AZ80flPJyyTvoCNqmydK3
	v3NJ0HIl0o05WXyAH5eXvdS9AWwQrvNYzCtSwAX/Ls3wxgkmjEhHUfq9Wic+hOlZUq7IghevRFX
	CbyA+b1Gvry8Bh706KMA4cVdu2YSkq3MNCIaSXK4imUTRH31FTRowxvu72X
X-Google-Smtp-Source: AGHT+IGPUbmiP+qBAkvL5swBm1dHC6B99KcD4evHef30iEFH0wLwNX1NEd7KmhaY77h1N4fWPe+n+Q==
X-Received: by 2002:a05:6214:19c7:b0:6d4:1662:348c with SMTP id 6a1803df08f44-6df9b1ea77bmr104647506d6.17.1736432783201;
        Thu, 09 Jan 2025 06:26:23 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810cf7bsm201507156d6.36.2025.01.09.06.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:26:22 -0800 (PST)
Message-ID: <fcd2ddec-e21c-4a4c-9d28-c9c8bce8e6d5@gmail.com>
Date: Thu, 9 Jan 2025 06:26:19 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support for multiple EAP methods in one config?
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

On 1/9/25 5:37 AM, Michael John wrote:
> Hello,
>
> I'm looking to see if IWD supports the ability to support multiple EAP method, like what can be done in wpa_supplicant.
At the moment no, there is no way to configure this.
>
> network={
>      ssid="example"
>      key_mgmt=WPA-EAP
>      eap=TTLS PEAP
>      identity="username"
>      password="password"
>      # Try basically every common inner method
>      phase2="autheap=MSCHAPV2 autheap=MD5 autheap=GTC autheap=OTP autheap=TLS auth=MSCHAPV2 auth=MSCHAP auth=PAP auth=CHAP auth=GTC"
> }
>
> My use case is that I'm given a username and password for a network but don't know the outer or inner protocols (or even if its personal or enterprise but I can determine that from the broadcast beacon).

So does the network actually support multiple inner methods? or is this 
just more of a "debugging" feature to determine which (single) method it 
supports. I'd be interested in the motivation for a feature like this. 
Is it:

   - There are _real_ networks that exist which support multiple EAP 
methods, or...

   - Your network administrators are not providing their clients with 
enough information.

I do know its possible to configure/allow multiple EAP methods with 
hostapd at least, so it is _possible_ that networks like this exist. I'm 
more just curious if its done ever in practice, and if so I guess that's 
something IWD might want to support.

Also, you should be able to determine at least if its PSK or enterprise 
based on the AKM in the beacon. And IWD will also print this in the 
debug logs when it scans.

Thanks,

James

>
> Thanks,
>
> Michael John
> Midmark Corporation
>
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
>
