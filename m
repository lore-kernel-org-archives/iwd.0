Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C852C85D
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1UQg2TH"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbfdb41a63so559096a34.0
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704402088; x=1705006888; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2k6//bN0lqD/fk0pnY4ygw/e+9/oqVzy+ABL52iB/4=;
        b=B1UQg2THC/elHc83aLJw2d3C9Kc4GK6kxvCeEPm903xeumDB/J08BB6/iQiMWHu/Dp
         UajnXrqCNqqUGX+WKpROeSrd1fvfGwRqqYMRZte9d28q0a+fvJEt2nl1IVxIV06vo68o
         Kv1QaAwrgPFqbdNQh9oCgZ8pPFd+N0ifplJ3s52/EplWD3yeHv/QAHx0k+Pel5P1+SIZ
         qnNP2LGWhxh/dkb6xZewjKZclxhslumSzqzxfkhLyPUl0GZ0/oWxaV9gAVJhUWbMDXHX
         tAKLLTNMM4s0J4BXscmSqxispZYMVfChZI8C2bDEKjPEmADaBdNK1YtiB2N8lsOkeZAT
         Gxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402088; x=1705006888;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2k6//bN0lqD/fk0pnY4ygw/e+9/oqVzy+ABL52iB/4=;
        b=oPgubVIJnnsPHUZVs9v83BJWId5L2+aNUbSxf1JMIciiJhR3HJAeP3w1dZZaM5uqwO
         z5UuuXfhe0kBccC6z8QI1uHtkhDu8G+mE1cziW9al39ED/v8OVTwM3jjPgfV6fRpchQr
         xRmV2exXsAJ/QM5kSsBYK8vFity6ultaggfP02OPTePVoEtaPP6drsogOhNSPQUwHdf5
         cNupw+gSWI4gKOlRlaHIhuDFx8aKFdwv2TDj4DPWYC6mGwXCmMRUpB3Aihy2VmkDC7g7
         BEzuQLO8EZ65VZDEzcW83ymwJKXP80H+5Ddjfkc/dR8f8nm6/7cB+zuSPKaMrsa0cN8i
         +XKg==
X-Gm-Message-State: AOJu0YzsNFaBRhwXd4spJFrOaxAU5Oj7WY/71HDaciJFloGR63/RIUa8
	Pzsk/kK1rePmEMV35ScYEn8=
X-Google-Smtp-Source: AGHT+IHPz6v/6cbLYTs7CUDxAoysBK+lm2QbBylb90m/gRJGKU3VyWiXvify5BYUetANxi+oJ9WM4A==
X-Received: by 2002:a9d:68d6:0:b0:6dc:623:68a0 with SMTP id i22-20020a9d68d6000000b006dc062368a0mr1183829oto.77.1704402088426;
        Thu, 04 Jan 2024 13:01:28 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id j18-20020a9d7d92000000b006dbf5ca14b9sm48964otn.47.2024.01.04.13.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:01:27 -0800 (PST)
Message-ID: <e0b3f24a-e95b-4b9c-bcdb-2d2f96ff2f99@gmail.com>
Date: Thu, 4 Jan 2024 15:01:26 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] station: add handling for new NETCONFIG state
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-3-prestwoj@gmail.com>
 <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
 <ee118809-a4a5-410b-b552-bdb1ad2cf347@gmail.com>
 <a0fbeeb4-f53a-4afc-aff3-8731ec914e71@gmail.com>
 <27188916-f1b9-4476-ab58-05d27d361820@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <27188916-f1b9-4476-ab58-05d27d361820@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> Hence why I think it is better to treat this as an initial connection failure 
>> rather than pretending that we roamed and dealing with the consequences.
> So when I originally sent the netconfig after roam change I wanted to actually 
> prevent any roaming until netconfig finished, but instead we allowed the roam 
> and restarted netconfig. So yes, I feel like this wasn't the right direction to 
> go. I'm thinking instead we should prevent any roaming, cap the netconfig time 
> (e.g. 15 seconds) and fail the connection if netconfig doesn't finish. Then we 

Preventing roaming would certainly be easier to implement, but the fact that you 
had roams during the initial connection (the original problem which prompted 
this change), probably means that we do want to allow roaming eventually.

6G in particular would benefit, since attaching to 2.4/5GHz frequencies first, 
then asking for neighbor reports and roaming to 6G is probably the best strategy 
compared to passively scanning on the 6 GHz band.

Regards,
-Denis
