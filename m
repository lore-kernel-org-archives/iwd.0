Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0E137750
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866212; cv=none; b=TUTH84LWYZoH3+tkHruTNnbMfIk1kxtkmh4K1p4QvfDLWjth2jL7wwvKj0fRe7MItvIoP6hiuRJW9S06AqfSEJWU9aDHXtDdFt+CkF5swDXplg7TnBgwxFNoR8t6+PsehzpLeLVQx0umo9yGsVZZZNRfg0oRyr4KRpU5FP8NVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866212; c=relaxed/simple;
	bh=rrkk8iF2apD1bpURh2nMb9d6sKJ7bVbNTmeBoxsOY7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qmDUTb5KPlr/YWd9oE+wEmdyDr1bQ0t4onScJHD/YiknffvXrmKH7rZwAOeuJJ0lm9SQoyCXuCoirTJrCqZiYxguhP8QoZ8JAJhHMzO7aQ4av5efgt0GQp1s8NbB1u1DZDiI7/4bTmKciO5Ng/qiuWlOekiWNfRx6xktN/wu1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2KJP3I6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2KJP3I6"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db50abf929so3413832b6e.2
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866210; x=1723471010; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zOrjA6VpifkZ2tPqA54JeU2U2kyLqj0cy0izKY0RQ+Y=;
        b=W2KJP3I6ZHValbdLaiAJOOEP59rXjdwsFm3TSEBvUovkdk2VGgH9Q3nCUOSPuE6BVE
         e2c+O15osGyV/eKw6Os5eUaMKlMNnUCQOZ31PMGnUIhMoH+XrFREf+nVcXqoK5Lbfgx7
         L7Od1krfu8Z+kmNdd0rIPAK/EMDU2vQki0DqiMF6973b/bGsieneh+bGWiyyHeo+aKeh
         GajLoXXQAfUB7IPH7pDhMOI6bjGJ8eJfhwVgUXg6HK3HhtjKr6O2bDDdCyFZ86m+QOn5
         EXjkcj++LLNT4uI6/GaEq/yMYHxAc2i9Q0W+X5tlw2+f285ogCusgi9v2LckafMWOL8L
         PXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866210; x=1723471010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOrjA6VpifkZ2tPqA54JeU2U2kyLqj0cy0izKY0RQ+Y=;
        b=KZy3vFKw/5YynHjGZqEtCLhcqbjGoogxPiACjCWOH8VTM+RjBQ23aZtsZLYfAKaFVH
         wBXKB3GKQNX8GVIVXdG6aUC3Y2bXUkh3BXSUPMcwxmAraJQWv1btA6Xb44MX4A3I8HNi
         qlNEfDuWitpmE2FwU8BdIUZHlqkAFG1eaY9aG4pO0Tftv8TnLVoh0hq7lMAcYRCPCJF6
         zmKbNEMNZiFfmeCYWPdxbllH/+Bo1Mk/BGircRBb4tn4GCPEI5UMhOSNh1YMK5MBoh74
         9yWvVfrIbkVkXnMqBgw3LpWKzutjGmfPdpu0iO/1hqkvNEF9Mux/Z4ev7i7fgv3yh8nh
         feSg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Jv/5fMPm9AMNM0z1Jwxve81XN6MI1QORSrnSnjg0Buw8q8cEVlIeDWKGRG1C2K0nP19u6bo0Fq38C5QhPFRMyaoJ
X-Gm-Message-State: AOJu0YyFLhzH5xsLhHv993n9SZrlpndCLMa7VzTu3pheRRmuFHcY2ZkW
	y0h1mIfv4I7dW2Dh0fO6Gr5BAczleGeg6f76eiBg7rcChNo4O+Qj
X-Google-Smtp-Source: AGHT+IG8FrWFYiiyzgA0vrZdd0dl+pxfR/tef8sWfo1sZIFiO1noGV2U1KZFDQCEClqL/+AmYEaz4w==
X-Received: by 2002:a05:6870:b61c:b0:25d:8d4:68ab with SMTP id 586e51a60fabf-26891ea5ac2mr13220348fac.40.1722866210104;
        Mon, 05 Aug 2024 06:56:50 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2689a6274b8sm2473495fac.42.2024.08.05.06.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 06:56:49 -0700 (PDT)
Message-ID: <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
Date: Mon, 5 Aug 2024 08:56:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: James Prestwood <prestwoj@gmail.com>, KeithG <ys3al35l@gmail.com>,
 iwd@lists.linux.dev
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> ...
>>   Device supports SAE with AUTHENTICATE command
> 
> So this is interesting... IWD does not expect a fullmac card to support 
> AUTHENTICATE but if this is the direction brcmfmac is going I guess we can 

That's because iw output is misleading.  This driver uses CMD_EXTERNAL_AUTH to 
tell iwd/wpa_s to transfer SAE authenticate frames via CMD_FRAME (similar to how 
iwd does FT-Auth frames).

Unfortunately the kernel never dedicated an actual capability bit to tell 
userspace that CMD_EXTERNAL_AUTH is being used.  They just reuse the generic 
FEATURE_SAE.

> support it. This is such a mess though and brcmfmac just needs to decide what 
> they are doing. This just makes things even more complicated as we now have 3 
> (?) ways to do SAE just on brcmfmac.

Its still just 2, SAE_OFFLOAD and EXTERNAL_AUTH

Regards,
-Denis
