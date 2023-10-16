Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06F339B7
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZNcf4u5"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57b9231e91dso2989570eaf.2
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483577; x=1698088377; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48ksChNhslrpW1ZGGY2YldPTtbU4JOmWUVoKUmDso1A=;
        b=iZNcf4u5+efbUSh0bJJX0kiLu6583WAQ1WbUPvmcnHR/wp7ogMNj3gcUqaCrrtNHFT
         HZtpglYCa3DCIhB5hWHJKMdKcVXVZN9lZvVDROEJ1iFWyNa0Wo8DzzuRqzBsBnol/xVq
         N7P4VcQ/qNUakGadypKi/+NOfUTNKmIG51f9oQlfVAYs9NygcNT8ip4e2W4sZgLv/X4a
         uUKRCFBuVF/2YVQeeh1OPor9pN0mhbUWptWnVz4vIWfwwxKLedqavoGqUOsV1VJzUPCE
         iGeBh0Lch9ahRJRDc6lPcvXcKlHvxVjrWQv/b9SuvkHcORKHNl4HCGo8LPko4xPnpj6s
         5e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483577; x=1698088377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48ksChNhslrpW1ZGGY2YldPTtbU4JOmWUVoKUmDso1A=;
        b=TPTm/PJkj3XmQHLfhU7rPS1I/j4mCZ02ZJeRalZSeEiHzXVWmInPgnaPvY7yroWWAD
         M2lnk8vIYa7r+DOnA8lJZZzjXiLzzJUidjKtsDnRvbm7N2arYEvX0Qxf3IxO1K2hiomk
         PcarYn54apinHKAB4tfFmbwdHwvN+YRT/dIqFsbur4CkIzxafYbuzMaV8sckYmLL92vP
         UkE66kx4RqDUOCIqmPx/xzPFDxTwiap2EWtsii5/yZ7tiD1fGXiSVPlkFZDGJNenpXBy
         pcep4HA/4+xWhcTHAspK6S4idP1R1AUkZpu+Cl94xudizk3givYHPZenKHH8hIpfM7jQ
         374g==
X-Gm-Message-State: AOJu0YwMglLSJKGNCX7xfV8IGxlCKALwY+ZMScSgiCgU4FxuVuvK9xCC
	SRVQHUgUT9gh48TpK07TFVw=
X-Google-Smtp-Source: AGHT+IHiM48iLoB+yvkzsNO6SZmdV+oRUBEdCOWpkmW8meglKm51NAvvcNka3/yNTDhtQEqSCmGzBw==
X-Received: by 2002:a4a:d10d:0:b0:581:5051:1968 with SMTP id k13-20020a4ad10d000000b0058150511968mr17720361oor.0.1697483577721;
        Mon, 16 Oct 2023 12:12:57 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y7-20020a4ac407000000b0057bcbc23738sm1180331oop.17.2023.10.16.12.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:12:57 -0700 (PDT)
Message-ID: <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
Date: Mon, 16 Oct 2023 14:12:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> FWIW, my 802.11ax mesh APs I have at home don't advertise the HE element either.
> 

I wonder if this is a bug?

According to 9.3.3.2 Beacon frame format:
"The HE Capabilities element is present if dot11HEOptionImplemented is true; 
otherwise, it is not present."

Regards,
-Denis

