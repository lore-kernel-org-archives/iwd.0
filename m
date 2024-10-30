Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E91BD9D3
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319345; cv=none; b=RfrOcELCNEol15FwzlUFTw7NxPkQIbmSPc/tR4AdYWrEJdhIxp1oGihppn0qFULJjxtruk0tBxH8akfnvn+2/hy1yvX6uGcrnw25Id0pxKp5Eox/Pet1BJlEZCQeTLapRnsQL5abfFDQrjMCxhnzWiUC/Pul3sgenBKTWPcRzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319345; c=relaxed/simple;
	bh=qAsmYQok+ZmNqe4dOxI/0kqOAs4+fSisJhVux95Aiik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfTAhz0CjXqd1mVdDopquCrimynMs2h+p7My5gP2LomsorwzOVZ4GJJD3e0AAYT27HApDRxeuS0U9apWXgzTAJD6YXzA6yd9f3BTi9/IkwdkRrwWyVvQT9iC6me9/iEED71uX0Ols/ob86nuH67Y9Vsvn/P1pOL7hpUWWx2Q6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmbhtlw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmbhtlw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c803787abso2122505ad.0
        for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319343; x=1730924143; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAsmYQok+ZmNqe4dOxI/0kqOAs4+fSisJhVux95Aiik=;
        b=bjmbhtlwkQbQFt6E0N2zj+VJJ5NlRY0bKTHxTg+hH589JZH1fN2RxkXbYQaFE4RWkk
         blmqPyW26Biip//KXJFBjs7Sej1ufTKHkjlngAPsb6r581nGKtk+5oIRiyRGnAutfS/G
         oaqg4YsRCicHZ3T3sJ7WNAcJisWyFPhaTNeJDhXtF3AdcKJ93TZcICX//rTa5ecfbIQq
         P7WFSbgrPTnoztC25kvOK7wyO/KAhb9iIsZ9bQWYHFEbAAE3oh6aDgDxx8RWtiv01Sup
         tN6Y1Hf6K17wNCqtKs3QAnTiBWDHMoskE36Fo8MC4OXnONPgIK1n+p/Toivf2AIwQ7Mw
         DGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319343; x=1730924143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAsmYQok+ZmNqe4dOxI/0kqOAs4+fSisJhVux95Aiik=;
        b=nAlGPwZKBoSgITS8Trx9KRugrAzaiPMjH78T1Jfr4VNdrUu3LswJlVue/B4xO0ZKAb
         u10wfpPNO2kQ572ZE3cYa+jEILTTnHzSEaTPYExOiDA/SC26Y/yU9lSd8TN0g6rG+HzR
         Zd84Y8Gb8OYlK2OKRvSOK57xl2dTHpYfraS3Zi91/l6Cwpr5L4QYkwJkPme0Xe5ZNHz5
         qx6Z+53lSaEiriwb+Pb0GX2PMQWLJwA/pKzcRyiRuEtaV5/5a0t3RKZWT24jNTBfIAGE
         NM4TprwvhxHr2mNl7BKgLTc3gGMuxx5z27s/hz8EPocqezKRvO/g+Bw+98G9O/0ZYlNQ
         4D4w==
X-Gm-Message-State: AOJu0YxhgnEbc9fhP3OXXwNVUFIyZxqtJemM1ZqjEAxo7i4ofkKFEgyK
	ygkfD+HpU62bE29mWiKSixIbHyGgaRajHdKXaGU2ENwSU2AstNzL
X-Google-Smtp-Source: AGHT+IFYLd2Wz+swS4w+FIN9AY+a56PlhIRr+RcYpkNGprIXldK+ep60x9WOfFGxPJq/tEvd6x5+Qg==
X-Received: by 2002:a17:902:e751:b0:20b:db4:d913 with SMTP id d9443c01a7336-210ed3f11demr111265055ad.11.1730319342704;
        Wed, 30 Oct 2024 13:15:42 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc01366bsm85608725ad.132.2024.10.30.13.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:15:42 -0700 (PDT)
Message-ID: <b134a703-6747-4b1a-a022-b61f7e282bfa@gmail.com>
Date: Wed, 30 Oct 2024 13:15:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
 <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

<snip>
> Okt 30 21:10:43 tavla iwd[1212]: Wireless daemon version 2.3
Your using IWD version 2.3 which doesn't support that.

Thanks,

James

