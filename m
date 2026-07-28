Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325B22D785
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245511; cv=none; b=CIoR5PepvRT43dJ0uwBVh1BlhiRe2uqpRosuA95ughNl73B7Bp9HWvaSHNexKMp0WckQ4yUAnkDlGN2hyB69ZXh9UfNTslE5tzkQAHp+edhIaT1VLSRDuqvYw6noNGejcGj1HGtsfsgFZz7s03gWM9J2HX7PHcy9FR+2fkibfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245511; c=relaxed/simple;
	bh=bXcieraPJxdpCHFrSIVkYzSbewmCgYNRy2nNQywgVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWAdnDK0tvKCbKoROoHKUALdDA3GJRwMX6KGzb9QY3D8pSe351ki2Pp59UQD08l4IjYdgfQLP1jMy3P+uSPPNA/xkPTIlh1xVwBvuByUfV0Q00IkQE2waQUF0htR8PobU0xqUp0uF5nnyZ1sfGaoIxxLfWZmItLj5zcFpJu5EkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns0aWqHi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns0aWqHi"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso3190521e87.1
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785245503; x=1785850303; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXcieraPJxdpCHFrSIVkYzSbewmCgYNRy2nNQywgVi0=;
        b=Ns0aWqHiouKHgqELRbmxRDzGzgXEV+my+IHnQbgEJrdMsHOlHg4ynmYRXNjbaePWIl
         X4yPjPc/pHlyqxLYIF0xD+N+Pggqjr+wWSyXAQFtFOqkGjzzfINV6Nb46eomsjPtgATD
         djLwFL/lcSK4Qi6d4iy8//xU1vYPz9ml0OHcHXeHUq23oRIDOEsutdjvU+Ii6VjKn6gP
         XqkE73ud2Of83wkGNC0bFXh/vBWwZu6ZNa54hfR0MuF0aD9QnkI2N25pyQZuXwsK/GQD
         kizOL8c4tYUKs0Hs7pujGrR3hhM0KKKAzsn/1JX91Rw0xq9GchbNxHnLTskDEs5ZSgO5
         Lqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245503; x=1785850303;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXcieraPJxdpCHFrSIVkYzSbewmCgYNRy2nNQywgVi0=;
        b=tI2/vULfkWBAuQTguplL9ZECrPBB8yG/GXuQ51tMFuOYi6d5CrEWM4cPEPvfRaGitH
         OF/upQSbfi69oT4mcT0IzMBwA1Dy0qhAd/eAZkBLFaBBauy+IOQUlLV0xQOtI/nNjcfc
         eUqC48fcD2PASU2ECeu3t0PGyJXrL4ExCd6JiZMKCDujfOiEoCbpRwEWcWTS80bCEISs
         Mn0wikEDCATdYOX71VpJWFYnSxBXYsDAL08+H9Eak2a6jhAOiUnIy1kvgmcrmGTfgAo+
         38zoRtnVcCzUZl8IOvNd8t4nVs9grVPsD8gJZlL7vuONrtCAO+6H5cFk8mbPMPxgyuGq
         ho9Q==
X-Gm-Message-State: AOJu0Yymt1amaXMNFwxMouXxcPrLykCnRvjbP8YmQCGuKMKVe0N8BS1M
	RTMIn+FhfNceX2MNhbOVWlycSWT89I4vw4jV12r92QDkTfhevwzlk8Dewxm3tRDz/2sj4g==
X-Gm-Gg: AR+sD13LeXZfqDwuL6iKJZt+gYvf+jEhJJELHKRZ9ixcIyeSyil3HHW4G1cr9bFQmcr
	oOBmTeQJ4h1pZC+7c+KYGcGzpvcje8Ser5oaSA7SFFC9S3/u9J++DJTow5e0CMDSV2Ha/IPl+5i
	ioBBgW277K0eoO4jEU4wlHYiNLnJz3g9n0D3ZD8FIAbwMF09SZvgjVqerfYZdv5/mU+NcFPMfxO
	Cg05GD+B3bK8Sg019DwHhJciluFNEEje8QfdtiM1leE6UpeagurA35IBnsTQb81XnlPOoNmvxE9
	zk4gprQnULwzbC7DuvBShMOmQ23bwmh0mxv/k61fnNN6vEGxqgUOlrYTGQ4pnvslbnyj12YbgxO
	LxN4HYgTRDm9LThmQH3BdGP+1pvSsRu3Gp2Vq+BbhsrZYg3eBqjAYdqTmCxjDoge1jDIUTwfFpD
	cISGos4G4=
X-Received: by 2002:a05:6512:68a:b0:5b0:ce5:a04f with SMTP id 2adb3069b0e04-5b2d0271ad0mr631907e87.61.1785245503084;
        Tue, 28 Jul 2026 06:31:43 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224cb4csm18942561fa.33.2026.07.28.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:31:42 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: Re: [PATCH v3 0/3] dbus: expose per-BSS RSN capabilities
Date: Tue, 28 Jul 2026 16:31:00 +0300
Message-ID: <20260728133104.3369436-1-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784069194.git.aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Hi James,

A gentle follow-up on this series, which has now been pending for two
weeks. All iwd CI checks passed. The corresponding NetworkManager MR is
currently blocked on the proposed iwd D-Bus API:

https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2464

Would you have time to review the API approach, or is there anything else
you would like changed or tested?

Thanks,
Aleks
