Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C57613D
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830490; cv=none; b=nw83GIo24d3V+kqZE3pUHMzclslfgbId7tdBsrbOzJGXEOm5Og8L1nrtAKtF7O/iETcRncW5YXiRyquGfUYk2WyHAIQd+FZX7bKm66Mm+NKmEVkok2/imwbz2lYAopwRjJnh17foj1M/X+soX0PLx9d8AE/J5gyuEvop+JtpLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830490; c=relaxed/simple;
	bh=Xz/yfgtVRpMavIsIzW3XIbKxwnCp06avHqOvQriI5qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L0wK+0vDKl/5YYh4wyN1BS38f+nQjsz4AI2/q5N69rW/D96bW+VNna/s8WNgjSL/gKI2FOdu0ehcJsRQ8eH2TtCvsbhtxi1PBIc3sJtoVoyv0uj5I07rySCn+bQU9+jlmN6/jCMMYGqfAFDBfee6N2+LdFv99Gan8EHOrXqNEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6rsEg5F; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6rsEg5F"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7092dd03223so15603a34.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721830488; x=1722435288; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82YVw/D56DtKNCk4J30LN/c9yeasGUrQHTuYCfzlGVs=;
        b=a6rsEg5FukqwmhHd0owGzPyQtGyOZuXwpmBD5SkTDecfOxOutR5JH2RJeVjN2gLFc4
         wJEEpS0W+7BZyNbRLYTLA8FZ9sQ31sfVn4vysWrctHRP/tkW6cQ2XqKYfcTnrpcFmEeV
         zDfMFgZRTLvZzWg5rBUf1Y8A3UmFBYrLxmxUUVCW9go/59zu7+UyHByNeoCDrCCM9Z0O
         ktAOChNoHc8w9d7ehtzAgeQn3RejqpTilD7xpKUP7/qksFo6RH1W2EXS2HK+xJXLbX6K
         YxWWyEpf6UdVCAcY6g9r+mAh/jtkto5vm/EjXGyBU2nn0iByxjuxiPvEucABurU1cidY
         EdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830488; x=1722435288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82YVw/D56DtKNCk4J30LN/c9yeasGUrQHTuYCfzlGVs=;
        b=lZmieGcmjEmE2NGBFGoQJuCvxc+ImXIbwYf4kbVVwa+8deIokBYIm1DCYdyqqRWcqm
         lnQvb5ClpydnYjuDet1ePNthhFeOEkSstmzdkauJu+aVXC91Ag+mIeB7aTTP51oVEaaU
         YxffdUxxcdKgrsqg9qsfDTipAKq51L+Az8HE2fsyrGUXuLVogBvJOYxIN7yXFvbDRF0u
         p+NjZeOSZkKjImlcUn7ur+qunD19iN2zM905tIK75yf6Z6i1RnD+Ckxb+RKtJ8VmqjHF
         QsZclubqdGs17CohCyiBlgUuyzQwz0g0mhKdslSKWWt0OwA35gcDIEU/H7hRPQNLamVA
         RAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8cmoIx1Lb9RqnUulAkhwz/sIjjM+1m1H6/CydOiT27eH2RVPMqniqL+TsQoq9tOZ1jlyvmcFVje3S3fyS9pihb0se
X-Gm-Message-State: AOJu0YyDZPs2IUc19k6dsbuxo8hK7N8vv2q3Hw3bl2KkGUXmYLKMuw6v
	m9Z1KH4w00M9/d+uJKJQnmEacg2YN+xrjq+MtPW9VoNPqisRbBJe
X-Google-Smtp-Source: AGHT+IE10D1HyJ5eLJvRkwkr6Wj9/W7EQOejrjxB2hQV/BYbkOW05rL848yZCIWktf3N3CUx8wO4nw==
X-Received: by 2002:a05:6830:6a8f:b0:703:69b5:1518 with SMTP id 46e09a7af769-709234361e9mr3631927a34.16.1721830488253;
        Wed, 24 Jul 2024 07:14:48 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5d59f081072sm335542eaf.45.2024.07.24.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:14:47 -0700 (PDT)
Message-ID: <d6c8a51d-3bf6-4035-94cc-f78f954397cf@gmail.com>
Date: Wed, 24 Jul 2024 09:14:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240724121443.1425256-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240724121443.1425256-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/24/24 7:14 AM, James Prestwood wrote:
> When the survey code was added it neglected to add the same
> cancelation logic that existed for the GET_SCAN call, i.e. if
> a scan was canceled and there was a pending GET_SURVEY to the
> kernel that needs to be canceled, and the request cleaned up.
> 
> Fixes: 35808debae ("scan: use GET_SURVEY for SNR calculation in ranking")
> ---
>   src/scan.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

