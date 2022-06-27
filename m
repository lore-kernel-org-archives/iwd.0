Received: from mail-108-mta173.mxroute.com (mail-108-mta173.mxroute.com [136.175.108.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3746B7
	for <iwd@lists.linux.dev>; Mon, 27 Jun 2022 19:39:46 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta173.mxroute.com (ZoneMTA) with ESMTPSA id 181a6a88a4700095ec.002
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 27 Jun 2022 19:34:32 +0000
X-Zone-Loop: 0607fd6b539cc57bf5f4ab65d520e39ce915dad48c62
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=In-Reply-To:References:From:Subject:Cc:To:Message-Id:
	Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uYGNsix9TOW4RHuwo7RYvlWlQB7TYRa4UoDG91ZYnrg=; b=LXbc2Y4Ov4pn9OeUlBIfMCk2QD
	R+46Zjbb5pJ8EYDFeMDSpajAFZbr12Do/zESUO9hfDIhvGipi79Po74v690+xSG64GMSECRvoUBZ5
	IW5qkyRf7OXyn+4MonEBxpm2HaJBREcqTHvo0z8h0M+gVSjx0htdRMPyXTQ7ZC+xe4ZMNdIETky2O
	2/UKqxIkJCTRKgCcYDbMkJkjXDTM2BbWg9gnY/TrE97CEwC2HsU12I5u2IzQorRXEF4qurxt/bAPW
	gOG76/L3tz+yZNClJvaoK9DuUytl2s4dMQ+FqCdsf+he4PFBtQcruNLPJ4KtIyoV7AikD9OTl1Rm3
	tkRQfngQ==;
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jun 2022 15:34:29 -0400
Message-Id: <CL162O7N3E3I.WLF09E8PNZZ7@laptop>
To: "James Prestwood" <prestwoj@gmail.com>, <iwd@lists.linux.dev>
Cc: 
Subject: Re: [PATCH 2/2] doc: Add new DeviceProvisioning API properties
From: "Jesse Lentz" <jesse@twosheds.org>
References: <20220624164346.254771-1-jesse@twosheds.org>
 <20220624164346.254771-2-jesse@twosheds.org>
 <d45f1ddbf7086cbf14425ef1220a5ad40c1c53e1.camel@gmail.com>
In-Reply-To: <d45f1ddbf7086cbf14425ef1220a5ad40c1c53e1.camel@gmail.com>
X-AuthUser: jesse@twosheds.org

Hi James,

> This looks good to me.
>
> Just a note for next time, please send with a "v2" prefix. This lets
> Patchwork remove old patch sets automatically.

Will do, thanks.

Sincerely,
Jesse
