Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26293542C8
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794760; cv=none; b=BPNFEZzwLe8Noa5Nzt1e5BGvyeXbF9TTfuhIhKikGlLwTxLdq5AEI/zDAUQlADQExVjB014g8EJn5AzL0xQ5r3Aj7TC4bNu+QDgvbaEKFLBbdfLqwyRlO+eOmnMUaDdEa+y63d0ItP9UZnNL670fE8EhMcSSgS8SoKheRFMDY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794760; c=relaxed/simple;
	bh=Gq2n3H6/rIBVV8lmQjjfSOYnxN9ZU9pgvw2TLJn29t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp7jekDSZREUmsMdfoHpvYtJJGzQUaZjkXs2FBzx9ilZWrI0uBT0NWD3ppHTEjpJo3jHO8QuV6CzRa7Gys0KD67ym1mzEmHiLfFUWzav2qfDyys785kDIO4OM7u45wivfs2ti7n/cyb3rEZUeh328mKzIKFasWvb4bKxFfVpz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2R2JfUa; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2R2JfUa"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d18f80b5c2so2026000a34.3
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769794758; x=1770399558; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCxSS0e73pD8cokZ/chmX7EA5qIwUPmdIBnwjxvxjpE=;
        b=P2R2JfUa8mHvWVtzs4mBtb9/8btWA7+wAlEw90A1qmmrnRkHbHkEgoj7vldYegfRs9
         EJDXA+UmyG/3Q8VHsRY0e/gETg8fw77/eq3Rj513FyXWqud7qeI0HcrglWnCq/Xcxc5G
         omp9F1ceL5iaVlJrberB+uM352ba9qc8ydjzgf6fnHPLMyzs8NDP6deAM6zTMfgDVShx
         2bqcn9l6UTjmAZ+7M6/ooxqieiZw1hqz72hdarAaiERu/hKmbYDhCuoehBo2qdaqWXZA
         pc8slvUHr2h6uxztXYx9dnKzBHczgykZGGrAWOR8sW7G8rJ1rT+5pQ8UFkYvJ+rPGakN
         Y9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794758; x=1770399558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCxSS0e73pD8cokZ/chmX7EA5qIwUPmdIBnwjxvxjpE=;
        b=U5Z/ZKpUQVMaUxEYGPmYdj7SxmvBU0b8MJvPKc5cgib5KzRqN5JQA+LmZRJ7uj8WH2
         2Mkg+k7IBKJAbXs5pSgqb5qF0ovrDFWlSRbahZkfys+FrIvSd8GrH0cJA0wdigrf6rO0
         lv+8xOwscHSdblHGmZi5DTLJlURqVxM0u1sLI15XdDawflKEjbYijd2PCSOzcOGOq8bE
         kCz0vGr+xpkIjl3ro1STXFCQMwXsNhslMRxCEFgnsCwGlsaNFPgQeXITZ5140iB74u3b
         apBZywJ+2x4Ua8C11tELvqx8lE0uTMXenXhv0u0PNoH11bQv7AlERqKBOMOmbZrxN4zY
         Gndw==
X-Gm-Message-State: AOJu0YwkdK49egTpNH43Hf7CddS8ZdlLptsfOS8Jf/N1F3yTcjiaUefi
	goMLq4G1kmNhafo2iMEB13vjBdnE2/4M91T209KMGjyI/Tj5WWWH6z61
X-Gm-Gg: AZuq6aJ1xJd3CiVo6Qdm13Hr2Rk87UChIMQx2L7Wp+hrUB+pm/Yy2N3SznySI451coM
	6jYs78Gixy6iZYsD7advQnGl2OxMLUE+hNzuvquXrSAsHQZ31GBQB+ipmlWAA8vilR6OwFhdYbC
	2GrM8wAyK/GKuz+iIxfxZFgml66fyuEZWOQcUb4z2S1Eb2H1JaswqE9kZOvr/ECImZHKwgZo3eM
	nXCM3BbFBTCfWZzEwRRUNJ3a9Klr/XXcCfEEp3kovCW6rOCN1Ib4wnD8pFaFJR7K5DnwuE7vs9h
	y0fNKEKIgNAsCUhERYf2g6vUPn+g+/fnbHjRi2xFHskjErZign7CWOSbVUWB4lYZl1w4OPJuXva
	sE8mydafs6sz7UCLDjI+maqVJ/j4uVeCCflQAMMc6xwABv/EaYKskaPE8FtHG51gGdnyXZfhklN
	odK7T2/HUxkIAFPl0d2I0B
X-Received: by 2002:a05:6830:82cb:b0:7cf:d88d:5dd5 with SMTP id 46e09a7af769-7d1a5233029mr2554533a34.5.1769794758218;
        Fri, 30 Jan 2026 09:39:18 -0800 (PST)
Received: from [172.16.49.130] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d18c7cf291sm5743358a34.19.2026.01.30.09.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:39:17 -0800 (PST)
Message-ID: <a8468bd1-d652-4e41-ba86-297b4f1a2f59@gmail.com>
Date: Fri, 30 Jan 2026 11:39:16 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to manually force the security protocol with IWD?
To: Bryce Johnson <bryce@redpinelabs.com>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
 <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com>
 <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
 <4ab7e9b9-be27-402b-834c-3e71bd58a476@gmail.com>
 <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

 > Here were the test cases
> For test case 10153_1:  The test bed AP beacons with no security.  The
> test case requires the STAUT to connect with WPA2-PSK only.  Because
> of the mismatch of security protocols, the connection will fail.

This is a tough one since iwd categorizes networks into SSID+security and treats 
each combo as a separate network.  In other words SSID Foobar that advertises 
Open and SSID Foobar that advertises WPA-Personal will be treated as two 
separate networks.

Best we can do is add some sort of global restriction setting to iwd (like 
always use WPA2+ or WPA3+).  But really, this is almost always not what a 
typical user would want.  Users do want to connect to Open/OWE networks, legacy 
networks, etc.

Another thing to try is to force OWE-only mode for the Open network, but I'm not 
sure whether that will work for the 'spirit' of what the test is trying to do. 
Adding SSID.open with something like:
"
[Settings]
TransitionDisable=true
DisabledTransitionModes=open
"

> 
> For test case 10165_1: The test bed AP advertises at WPA2-Personal
> only.  The test case requires the STAUT to connect with WPA3-Personal.
> Because of the mismatch of security protocols, the connection will
> also fail.

This is a little bit easier.  You can add a SSID.psk setting with the following:
"
[Settings]
TransitionDisable=true
DisbledTransitionModes=personal
"

Refer to man 5 iwd.network for more details.

Regards,
-Denis
